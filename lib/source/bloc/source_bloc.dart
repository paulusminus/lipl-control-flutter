import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_repo/lipl_repo.dart';
import 'package:logging/logging.dart';

part 'source_event.dart';
part 'source_state.dart';

final Logger log = Logger('$SourceBloc');

class SourceBloc extends Bloc<SourceEvent, SourceState> {
  SourceBloc({
    required LiplRestStorage liplRestStorage,
  })  : _liplRestStorage = liplRestStorage,
        super(
          const SourceState(),
        ) {
    on<SourceSubscriptionRequested>(_onSubscriptionRequested);
    on<SourceTabChanged>(_onTabChanged);
  }

  final LiplRestStorage _liplRestStorage;

  void _onTabChanged(
    SourceTabChanged event,
    Emitter<SourceState> emit,
  ) {
    log.info('Handling on tab changed');
    emit(state.copyWith(selectedTab: () => event.tab));
  }

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
        lyrics: () => data.lyrics,
        playlists: () => data.playlists,
      ),
      onError: (_, __) => state.copyWith(
        status: () => SourceStatus.failure,
      ),
    );
  }
}
