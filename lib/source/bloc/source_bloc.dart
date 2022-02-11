import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_bloc/dal/dal.dart';
import 'package:lipl_bloc/model/model.dart';

part 'source_event.dart';
part 'source_state.dart';

class SourceBloc extends Bloc<SourceEvent, SourceState> {
  SourceBloc({
    required Dal dal,
  })  : _dal = dal,
        super(
          SourceState.initial(),
        ) {
    on<SourceSubscriptionRequested>(_onSubscriptionRequested);
    on<SourcePlaylistSelected>(_onPlaylistSelected);
  }

  final Dal _dal;

  Future<void> _onSubscriptionRequested(
    SourceSubscriptionRequested event,
    Emitter<SourceState> emit,
  ) async {
    emit(
      SourceState.loading(),
    );

    try {
      final List<Lyric> lyrics = await _dal.getLyrics();
      final List<Playlist> playlists = await _dal.getPlaylists();
      emit(
        state.copyWith(
          lyrics: () => lyrics,
          playlists: () => playlists,
          status: () => SourceStatus.success,
        ),
      );
    } catch (error) {
      emit(
        SourceState.failure(),
      );
    }
  }

  void _onPlaylistSelected(
    SourcePlaylistSelected event,
    Emitter<SourceState> emit,
  ) {
    emit(
      state.copyWith(selectedPlaylist: () => event.playlist),
    );
  }
}
