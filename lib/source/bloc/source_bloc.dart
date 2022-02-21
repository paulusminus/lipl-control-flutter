import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_repo/lipl_repo.dart';
// import 'package:preferences_local_storage/preferences_local_storage.dart';
// import 'package:rxdart/rxdart.dart';

part 'source_event.dart';
part 'source_state.dart';

class SourceBloc extends Bloc<SourceEvent, SourceState> {
  SourceBloc({
    required LiplRestStorage liplRestStorage,
    // required PreferencesLocalStorage<Credentials> preferencesLocalStorage,
  })  : _liplRestStorage = liplRestStorage,
        // _preferencesLocalStorage = preferencesLocalStorage,
        super(
          const SourceState(),
        ) {
    on<SourceSubscriptionRequested>(_onSubscriptionRequested);
    on<SourceTabChanged>(_onTabChanged);
  }

  final LiplRestStorage _liplRestStorage;
  // final PreferencesLocalStorage<Credentials> _preferencesLocalStorage;

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
      onError: (Object error, __) => state.copyWith(
        status: () => (error is NoCredentialsException)
            ? SourceStatus.noCredentials
            : SourceStatus.failure,
      ),
    );
  }
}
