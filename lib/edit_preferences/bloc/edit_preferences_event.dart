part of 'edit_preferences_bloc.dart';

abstract class EditPreferencesEvent extends Equatable {}

class EditPreferencesEventPasswordChanged extends EditPreferencesEvent {
  EditPreferencesEventPasswordChanged({required this.password});
  final String password;

  @override
  List<Object?> get props =>
      <Object?>[EditPreferencesEventPasswordChanged, password];
}

class EditPreferencesEventUsernameChanged extends EditPreferencesEvent {
  EditPreferencesEventUsernameChanged({required this.username});
  final String username;

  @override
  List<Object?> get props =>
      <Object?>[EditPreferencesEventUsernameChanged, username];
}

class EditPreferencesEventBaseUrlChanged extends EditPreferencesEvent {
  EditPreferencesEventBaseUrlChanged({required this.baseUrl});
  final String baseUrl;

  @override
  List<Object?> get props =>
      <Object?>[EditPreferencesEventBaseUrlChanged, baseUrl];
}

class EditPreferencesEventSubmitted extends EditPreferencesEvent {
  @override
  List<Object?> get props => <Object?>[EditPreferencesEventSubmitted];
}

class EditPreferencesEventLoaded extends EditPreferencesEvent {
  @override
  List<Object?> get props => <Object?>[EditPreferencesEventLoaded];
}
