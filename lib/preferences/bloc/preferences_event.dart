part of 'preferences_bloc.dart';

abstract class PreferencesEvent extends Equatable {}

class PreferencesEventPasswordChanged extends PreferencesEvent {
  PreferencesEventPasswordChanged({required this.password});
  final String password;

  @override
  List<Object?> get props =>
      <Object?>[PreferencesEventPasswordChanged, password];
}

class PreferencesEventUsernameChanged extends PreferencesEvent {
  PreferencesEventUsernameChanged({required this.username});
  final String username;

  @override
  List<Object?> get props =>
      <Object?>[PreferencesEventUsernameChanged, username];
}

class PreferencesEventSubmitted extends PreferencesEvent {
  @override
  List<Object?> get props => <Object?>[PreferencesEventSubmitted];
}

class PreferencesEventLoaded extends PreferencesEvent {
  @override
  List<Object?> get props => <Object?>[PreferencesEventLoaded];
}
