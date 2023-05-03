import 'dart:convert';
import 'package:equatable/equatable.dart';

class LiplPreferences extends Equatable {
  const LiplPreferences({
    required this.username,
    required this.password,
    required this.baseUrl,
  });
  final String username;
  final String password;
  final String baseUrl;

  LiplPreferences copyWith({
    String? username,
    String? password,
    String? baseUrl,
  }) =>
      LiplPreferences(
        username: username ?? this.username,
        password: password ?? this.password,
        baseUrl: baseUrl ?? this.baseUrl,
      );

  String serialize() => jsonEncode(
        <String, dynamic>{
          'username': username,
          'password': password,
          'base_url': baseUrl,
        },
      );

  factory LiplPreferences.initial() {
    return const LiplPreferences(username: '', password: '', baseUrl: '');
  }

  factory LiplPreferences.deserialize(String s) {
    final json = jsonDecode(s);
    return LiplPreferences(
      username: json['username'],
      password: json['password'],
      baseUrl: json['base_url'],
    );
  }

  @override
  List<Object?> get props => [username, password, baseUrl];
}
