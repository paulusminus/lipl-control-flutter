import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_repo/lipl_repo.dart';

part 'source_event.dart';
part 'source_state.dart';

class SourceBloc extends Bloc<SourceEvent, SourceState> {
  SourceBloc({
    required LiplRestStorage liplRestStorage,
  })  : _liplRestStorage = liplRestStorage,
        super(
          const SourceState(),
        ) {
    on<SourceSubscriptionRequested>(_onSubscriptionRequested);
    on<SourcePlaylistSelected>(_onPlaylistSelected);
    on<SourceLyricToggleExpanded>(_onSourceLyricToggleExpanded);
  }

  final LiplRestStorage _liplRestStorage;

  Future<void> _onSubscriptionRequested(
    SourceSubscriptionRequested event,
    Emitter<SourceState> emit,
  ) async {
    emit(
      SourceState.loading(),
    );

    await emit.forEach(
      _liplRestStorage.getData(),
      onData: (Data data) => state.copyWith(
        status: () => SourceStatus.success,
        lyrics: () => data.lyrics
            .map((Lyric lyric) => Expandable<Lyric>(data: lyric))
            .toList(),
        playlists: () => data.playlists,
      ),
      onError: (_, __) => state.copyWith(
        status: () => SourceStatus.failure,
      ),
    );
  }

  void _onSourceLyricToggleExpanded(
      SourceLyricToggleExpanded event, Emitter<SourceState> emit) {
    emit(
      state.copyWith(
        lyrics: () => state.lyrics
            .map(
              (Expandable<Lyric> lyric) =>
                  lyric.data.id == event.id ? lyric.toggled() : lyric,
            )
            .toList(),
      ),
    );
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
