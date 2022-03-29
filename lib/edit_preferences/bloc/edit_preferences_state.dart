part of 'edit_preferences_bloc.dart';

enum EditPreferencesStatus { initial, success, error }

class EditPreferencesState extends Equatable {
  const EditPreferencesState({
    required this.username,
    required this.password,
    required this.baseUrl,
    required this.status,
  });

  final String username;
  final String password;
  final String baseUrl;
  final EditPreferencesStatus status;

  EditPreferencesState copyWith({
    String? username,
    String? password,
    String? baseUrl,
    EditPreferencesStatus? status,
  }) =>
      EditPreferencesState(
        username: username ?? this.username,
        password: password ?? this.password,
        baseUrl: baseUrl ?? this.baseUrl,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => <Object?>[username, password, baseUrl, status];
}
