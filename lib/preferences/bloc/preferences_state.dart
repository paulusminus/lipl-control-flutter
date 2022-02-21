part of 'preferences_bloc.dart';

enum PreferencesStatus { initial, success, error }

class PreferencesState extends Equatable {
  const PreferencesState({
    required this.username,
    required this.password,
    required this.status,
  });

  final String username;
  final String password;
  final PreferencesStatus status;

  PreferencesState copyWith({
    String? username,
    String? password,
    PreferencesStatus? status,
  }) =>
      PreferencesState(
        username: username ?? this.username,
        password: password ?? this.password,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => <Object?>[username, password];
}
