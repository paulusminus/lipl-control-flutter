import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_repo/lipl_repo.dart';
import 'package:preferences_local_storage/preferences_local_storage.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesBloc(
      {required PreferencesLocalStorage<Credentials> preferencesLocalStorage})
      : _preferencesLocalStorage = preferencesLocalStorage,
        super(
          const PreferencesState(
            username: '',
            password: '',
            status: PreferencesStatus.initial,
          ),
        ) {
    on<PreferencesEventUsernameChanged>(_onUsernameChanged);
    on<PreferencesEventPasswordChanged>(_onPasswordChanged);
    on<PreferencesEventLoaded>(_onLoaded);
    on<PreferencesEventSubmitted>(_onSubmitted);
    preferencesLocalStorage.get().listen((Credentials? credentials) {
      add(
        PreferencesEventUsernameChanged(
          username: credentials?.username ?? '',
        ),
      );
      add(
        PreferencesEventPasswordChanged(
          password: credentials?.password ?? '',
        ),
      );
      add(PreferencesEventLoaded());
    });
  }

  final PreferencesLocalStorage<Credentials> _preferencesLocalStorage;

  void _onLoaded(PreferencesEventLoaded event, Emitter<PreferencesState> emit) {
    log.info('loaded');
  }

  void _onUsernameChanged(
      PreferencesEventUsernameChanged event, Emitter<PreferencesState> emit) {
    emit(state.copyWith(username: event.username));
  }

  // void _onLoaded(PreferencesEventLoaded event, Emitter<PreferencesState> emit) {
  //   emit(
  //     state.copyWith(
  //       status: PreferencesStatus.success,
  //     ),
  //   );
  // }

  void _onPasswordChanged(
      PreferencesEventPasswordChanged event, Emitter<PreferencesState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onSubmitted(
      PreferencesEventSubmitted event, Emitter<PreferencesState> emit) async {
    if (state.password.trim().isNotEmpty && state.username.trim().isNotEmpty) {
      try {
        await _preferencesLocalStorage.set(
          Credentials(
            username: state.username,
            password: state.password,
          ),
        );
        emit(
          state.copyWith(
            username: '',
            password: '',
            status: PreferencesStatus.success,
          ),
        );
      } catch (error) {
        emit(
          state.copyWith(
            status: PreferencesStatus.error,
          ),
        );
      }
    }
  }
}
