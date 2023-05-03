import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';

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

enum LiplRestStatus { initial, loading, success, unauthorized, changing }

class LiplRestState extends Equatable {
  const LiplRestState({
    required this.lyrics,
    required this.playlists,
    required this.status,
    required this.api,
  });

  factory LiplRestState.initial() => LiplRestState(
        lyrics: const [],
        playlists: const [],
        status: LiplRestStatus.initial,
        api: apiFromConfig(),
      );

  final List<Lyric> lyrics;
  final List<Playlist> playlists;
  final LiplRestStatus status;
  final LiplRestApi api;

  LiplRestState copyWith({
    List<Lyric>? lyrics,
    List<Playlist>? playlists,
    LiplRestStatus? status,
    LiplRestApi? api,
  }) =>
      LiplRestState(
        lyrics: lyrics ?? this.lyrics,
        playlists: playlists ?? this.playlists,
        status: status ?? this.status,
        api: api ?? this.api,
      );

  @override
  List<Object?> get props => [lyrics, playlists, status, api];
}

abstract class LiplRestEvent {}

class LiplRestEventLoad extends LiplRestEvent {
  LiplRestEventLoad({required this.api});
  final LiplRestApi api;
}

class LiplRestUnauthorized extends LiplRestEvent {}

class LiplRestEventPostLyric extends LiplRestEvent {
  LiplRestEventPostLyric({required this.lyricPost});
  final LyricPost lyricPost;
}

class LiplRestEventPutLyric extends LiplRestEvent {
  LiplRestEventPutLyric({required this.lyric});
  final Lyric lyric;
}

class LiplRestEventDeleteLyric extends LiplRestEvent {
  LiplRestEventDeleteLyric({required this.id});
  final String id;
}

class LiplRestEventPostPlaylist extends LiplRestEvent {
  LiplRestEventPostPlaylist({required this.playlistPost});
  final PlaylistPost playlistPost;
}

class LiplRestEventPutPlaylist extends LiplRestEvent {
  LiplRestEventPutPlaylist({required this.playlist});
  final Playlist playlist;
}

class LiplRestEventDeletePlaylist extends LiplRestEvent {
  LiplRestEventDeletePlaylist({required this.id});
  final String id;
}

class LiplRestBloc extends Bloc<LiplRestEvent, LiplRestState> {
  LiplRestBloc() : super(LiplRestState.initial()) {
    on<LiplRestEventLoad>(_onLoad);
    on<LiplRestUnauthorized>(_onUnauthorized);
    on<LiplRestEventPostLyric>(_onPostLyric);
    on<LiplRestEventPutLyric>(_onPutLyric);
    on<LiplRestEventDeleteLyric>(_onDeleteLyric);
    on<LiplRestEventPostPlaylist>(_onPostPlaylist);
    on<LiplRestEventPutPlaylist>(_onPutPlaylist);
    on<LiplRestEventDeletePlaylist>(_onDeletePlaylist);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (error is DioError) {
      if (error.response?.statusCode == 401) {
        add(LiplRestUnauthorized());
      }
    }
    super.onError(error, stackTrace);
  }

  void _onUnauthorized(
    LiplRestUnauthorized event,
    Emitter<LiplRestState> emit,
  ) {
    emit(state.copyWith(status: LiplRestStatus.unauthorized));
  }

  Future<void> _onLoad(
    LiplRestEventLoad event,
    Emitter<LiplRestState> emit,
  ) async {
    emit(
      state.copyWith(
        api: event.api,
        status: LiplRestStatus.loading,
      ),
    );
    List<Lyric> lyrics = []; // = await state.api.getLyrics();
    List<Playlist> playlists = []; // = await state.api.getPlaylists();
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
        status: LiplRestStatus.success,
      ),
    );
  }

  Future<void> _onPostLyric(
    LiplRestEventPostLyric event,
    Emitter<LiplRestState> emit,
  ) async {
    emit(state.copyWith(status: LiplRestStatus.changing));
    final lyric = await state.api.postLyric(event.lyricPost);
    emit(
      state.copyWith(
        lyrics: state.lyrics.addItem(lyric),
        status: LiplRestStatus.success,
      ),
    );
  }

  Future<void> _onPutLyric(
    LiplRestEventPutLyric event,
    Emitter<LiplRestState> emit,
  ) async {
    emit(state.copyWith(status: LiplRestStatus.changing));
    final lyric = await state.api.putLyric(event.lyric.id, event.lyric);
    emit(
      state.copyWith(
        lyrics: state.lyrics.replaceItem(lyric),
        status: LiplRestStatus.success,
      ),
    );
  }

  Future<void> _onDeleteLyric(
    LiplRestEventDeleteLyric event,
    Emitter<LiplRestState> emit,
  ) async {
    emit(state.copyWith(status: LiplRestStatus.changing));
    await state.api.deleteLyric(event.id);
    emit(
      state.copyWith(
        lyrics: state.lyrics.removeItemById(event.id),
        playlists: state.playlists
            .map((Playlist p) => p.withoutMember(event.id))
            .toList(),
        status: LiplRestStatus.success,
      ),
    );
  }

  Future<void> _onPostPlaylist(
    LiplRestEventPostPlaylist event,
    Emitter<LiplRestState> emit,
  ) async {
    emit(state.copyWith(status: LiplRestStatus.changing));
    final playlist = await state.api.postPlaylist(event.playlistPost);
    emit(
      state.copyWith(
        playlists: state.playlists.addItem(playlist),
        status: LiplRestStatus.success,
      ),
    );
  }

  Future<void> _onPutPlaylist(
    LiplRestEventPutPlaylist event,
    Emitter<LiplRestState> emit,
  ) async {
    emit(state.copyWith(status: LiplRestStatus.changing));
    final playlist =
        await state.api.putPlaylist(event.playlist.id, event.playlist);
    emit(
      state.copyWith(
        playlists: state.playlists.replaceItem(playlist),
        status: LiplRestStatus.success,
      ),
    );
  }

  Future<void> _onDeletePlaylist(
    LiplRestEventDeletePlaylist event,
    Emitter<LiplRestState> emit,
  ) async {
    emit(state.copyWith(status: LiplRestStatus.changing));
    await state.api.deletePlaylist(event.id);
    emit(
      state.copyWith(
        playlists: state.playlists.removeItemById(event.id),
        status: LiplRestStatus.success,
      ),
    );
  }
}
