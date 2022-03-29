import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_preferences_bloc/lipl_preferences_bloc.dart';
import 'package:lipl_repo/lipl_repo.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required LiplPreferencesBloc liplPreferencesBloc,
    required LiplRestStorage liplRestStorage,
  })  : _liplRestStorage = liplRestStorage,
        super(
          const AppState(),
        ) {
    final Stream<LiplPreferencesState> successStream =
        liplPreferencesBloc.stream.where((LiplPreferencesState state) =>
            state.status == LiplPreferencesStatus.succes);

    final Stream<String> usernameStream = successStream
        .map((LiplPreferencesState state) => state.username)
        .distinct();

    final Stream<String> passwordStream = successStream
        .map((LiplPreferencesState state) => state.password)
        .distinct();

    final Stream<String> baseUrlStream = successStream
        .map((LiplPreferencesState state) => state.baseUrl)
        .distinct();

    on<AppSubscriptionRequested>(_onSubscriptionRequested);
    on<AppTabChanged>(_onTabChanged);
    on<AppPlaylistDeletionRequested>(_onPlaylistDeletionRequested);
    on<AppLyricDeletionRequested>(_onLyricDeletionRequested);
  }

  final LiplRestStorage _liplRestStorage;

  Future<void> _onPlaylistDeletionRequested(
    AppPlaylistDeletionRequested event,
    Emitter<AppState> emit,
  ) async {
    await _liplRestStorage.deletePlaylist(event.id);
  }

  Future<void> _onLyricDeletionRequested(
    AppLyricDeletionRequested event,
    Emitter<AppState> emit,
  ) async {
    await _liplRestStorage.deleteLyric(event.id);
  }

  void _onTabChanged(
    AppTabChanged event,
    Emitter<AppState> emit,
  ) {
    log.info('Handling on tab changed');
    emit(state.copyWith(selectedTab: () => event.tab));
  }

  Future<void> _onSubscriptionRequested(
    AppSubscriptionRequested event,
    Emitter<AppState> emit,
  ) async {
    emit(
      AppState.loading(),
    );

    await emit.forEach(
      _liplRestStorage.getData(),
      onData: (Data data) => state.copyWith(
        status: () => AppStatus.success,
        lyrics: () => data.lyrics,
        playlists: () => data.playlists,
      ),
      onError: (Object error, __) => state.copyWith(
        status: () => (error is NoCredentialsException)
            ? AppStatus.noCredentials
            : AppStatus.failure,
      ),
    );
  }
}
