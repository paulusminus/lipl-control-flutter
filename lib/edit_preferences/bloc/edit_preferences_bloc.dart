import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_preferences_bloc/lipl_preferences_bloc.dart';

part 'edit_preferences_event.dart';
part 'edit_preferences_state.dart';

class EditPreferencesBloc
    extends Bloc<EditPreferencesEvent, EditPreferencesState> {
  EditPreferencesBloc({required this.liplPreferencesBloc})
      : super(
          EditPreferencesState(
            username: liplPreferencesBloc.state.username,
            password: liplPreferencesBloc.state.password,
            baseUrl: liplPreferencesBloc.state.baseUrl,
            status: EditPreferencesStatus.initial,
          ),
        ) {
    on<EditPreferencesEventUsernameChanged>(_onUsernameChanged);
    on<EditPreferencesEventPasswordChanged>(_onPasswordChanged);
    on<EditPreferencesEventBaseUrlChanged>(_onBaseUrlChanged);
    on<EditPreferencesEventSubmitted>(_onSubmitted);
  }

  final LiplPreferencesBloc liplPreferencesBloc;

  void _onUsernameChanged(EditPreferencesEventUsernameChanged event,
      Emitter<EditPreferencesState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _onPasswordChanged(EditPreferencesEventPasswordChanged event,
      Emitter<EditPreferencesState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onBaseUrlChanged(EditPreferencesEventBaseUrlChanged event,
      Emitter<EditPreferencesState> emit) {
    emit(state.copyWith(baseUrl: event.baseUrl));
  }

  void _onSubmitted(
      EditPreferencesEventSubmitted event, Emitter<EditPreferencesState> emit) {
    if (state.password.trim().isNotEmpty && state.username.trim().isNotEmpty) {
      liplPreferencesBloc.add(
        LiplPreferencesEventAllChanged(
          username: state.username,
          password: state.password,
          baseUrl: state.baseUrl,
        ),
      );

      emit(
        state.copyWith(
          username: '',
          password: '',
          status: EditPreferencesStatus.success,
        ),
      );
    }
  }
}
