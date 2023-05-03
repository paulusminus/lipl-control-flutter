import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'lipl_rest_model.dart';
import 'lipl_rest_api.dart';

extension ListX<T extends Summary> on List<T> {
  List<T> removeItemById(String id) => where((t) => t.id != id).toList();

  List<T> sortByTitle() {
    final result = [...this];
    result.sort(
      (T a, T b) => a.title.compareTo(b.title),
    );
    return result;
  }

  List<T> addItem(T t) => [...this, t].sortByTitle();

  List<T> replaceItem(T t) => map(
        (T e) => e.id == t.id ? t : e,
      ).toList().sortByTitle();
}

enum RestStatus { initial, loading, success, unauthorized, changing }

class RestState extends Equatable {
  const RestState({
    required this.lyrics,
    required this.playlists,
    required this.status,
    required this.api,
  });

  factory RestState.initial() => RestState(
        lyrics: const [],
        playlists: const [],
        status: RestStatus.initial,
        api: apiFromConfig(),
      );

  final List<Lyric> lyrics;
  final List<Playlist> playlists;
  final RestStatus status;
  final LiplRestApiInterface api;

  RestState copyWith({
    List<Lyric>? lyrics,
    List<Playlist>? playlists,
    RestStatus? status,
    LiplRestApiInterface? api,
  }) =>
      RestState(
        lyrics: lyrics ?? this.lyrics,
        playlists: playlists ?? this.playlists,
        status: status ?? this.status,
        api: api ?? this.api,
      );

  @override
  List<Object?> get props => [lyrics, playlists, status, api];
}

class LiplRestCubit extends Cubit<RestState> {
  LiplRestCubit() : super(RestState.initial());

  Stream<List<Lyric>> get lyricsStream => stream
      .where((state) => state.status == RestStatus.success)
      .map((state) => state.lyrics);

  Stream<List<Playlist>> get playlistsStream => stream
      .where((state) => state.status == RestStatus.success)
      .map((state) => state.playlists);

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (error is DioError) {
      if (error.response?.statusCode == 401) {
        emit(state.copyWith(status: RestStatus.unauthorized));
      }
    }
    super.onError(error, stackTrace);
  }

  Future<void> _runAsync(Future<void> Function() runnable) async {
    try {
      await runnable();
    } catch (error) {
      addError(error);
    }
  }

  Future<void> load(LiplRestApiInterface api) => _runAsync(() async {
        emit(
          state.copyWith(
            api: api,
            status: RestStatus.loading,
          ),
        );
        List<Lyric> lyrics = [];
        List<Playlist> playlists = [];
        await Future.wait<void>(
          [
            state.api.getLyrics().then((value) {
              lyrics = value;
            }),
            state.api.getPlaylists().then((value) {
              playlists = value;
            }),
          ],
        );
        emit(
          state.copyWith(
            lyrics: lyrics.sortByTitle(),
            playlists: playlists.sortByTitle(),
            status: RestStatus.success,
          ),
        );
      });

  Future<void> postLyric(LyricPost lyricPost) => _runAsync(() async {
        emit(state.copyWith(status: RestStatus.changing));
        final lyric = await state.api.postLyric(lyricPost);
        emit(
          state.copyWith(
            lyrics: state.lyrics.addItem(lyric),
            status: RestStatus.success,
          ),
        );
      });

  Future<void> putLyric(Lyric lyric) => _runAsync(() async {
        emit(state.copyWith(status: RestStatus.changing));
        final Lyric returnedLyric = await state.api.putLyric(lyric.id, lyric);
        emit(
          state.copyWith(
            lyrics: state.lyrics.replaceItem(returnedLyric),
            status: RestStatus.success,
          ),
        );
      });

  Future<void> deleteLyric(String id) => _runAsync(() async {
        emit(state.copyWith(status: RestStatus.changing));
        await state.api.deleteLyric(id);
        emit(
          state.copyWith(
            lyrics: state.lyrics.removeItemById(id),
            playlists: state.playlists
                .map((Playlist p) => p.withoutMember(id))
                .toList(),
            status: RestStatus.success,
          ),
        );
      });

  Future<void> postPlaylist(PlaylistPost playlistPost) => _runAsync(() async {
        emit(state.copyWith(status: RestStatus.changing));
        final playlist = await state.api.postPlaylist(playlistPost);
        emit(
          state.copyWith(
            playlists: state.playlists.addItem(playlist),
            status: RestStatus.success,
          ),
        );
      });

  Future<void> putPlaylist(Playlist playlist) => _runAsync(() async {
        emit(state.copyWith(status: RestStatus.changing));
        final Playlist playlistReturned =
            await state.api.putPlaylist(playlist.id, playlist);
        emit(
          state.copyWith(
            playlists: state.playlists.replaceItem(playlistReturned),
            status: RestStatus.success,
          ),
        );
      });

  Future<void> deletePlaylist(String id) => _runAsync(() async {
        emit(state.copyWith(status: RestStatus.changing));
        await state.api.deletePlaylist(id);
        emit(
          state.copyWith(
            playlists: state.playlists.removeItemById(id),
            status: RestStatus.success,
          ),
        );
      });
}
