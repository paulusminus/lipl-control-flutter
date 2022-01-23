import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_test/dal/dal.dart';
import 'package:lipl_test/model/model.dart';

enum Status {
  uninitialized,
  loading,
  error,
  loaded,
}

class FullState extends Equatable {
  const FullState({
    required this.status,
    required this.lyrics,
    required this.playlists,
  });

  final Status status;
  final List<Lyric> lyrics;
  final List<Playlist> playlists;

  @override
  List<Object> get props => <Object>[status, lyrics, playlists];
}

class FullCubit extends Cubit<FullState> {
  FullCubit({required this.dal})
      : super(const FullState(
            status: Status.uninitialized,
            lyrics: <Lyric>[],
            playlists: <Playlist>[]));

  final Dal dal;

  Future<void> load() async {
    emit(const FullState(
        status: Status.loading, lyrics: <Lyric>[], playlists: <Playlist>[]));

    try {
      final List<List<Object>> data = await Future.wait(<Future<List<Object>>>[
        dal.getLyrics(),
        dal.getPlaylists(),
      ]);
      emit(FullState(
          status: Status.loaded,
          lyrics: data[0] as List<Lyric>,
          playlists: data[1] as List<Playlist>));
    } catch (e) {
      emit(const FullState(
          status: Status.error, lyrics: <Lyric>[], playlists: <Playlist>[]));
    }
  }
}
