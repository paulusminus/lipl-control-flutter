import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class Credentials extends Equatable {
  static const String usernameKey = 'username';
  static const String passwordKey = 'password';

  const Credentials({required this.username, required this.password});
  final String username;
  final String password;

  @override
  List<Object?> get props => [username, password];

  @override
  String toString() => '$username:$password';
}

String _basicAuthenticationHeaderValue({
  required Credentials credentials,
}) {
  List<int> bytes = utf8.encode(credentials.toString());
  final encoded = base64Encode(bytes);
  return 'Basic $encoded';
}

Dio basicAuthenticationDio({required Credentials credentials}) {
  return Dio()
    ..interceptors.add(
      basicAuthentication(
        credentials: credentials,
      ),
    );
}

InterceptorsWrapper basicAuthentication({required Credentials credentials}) {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers.addAll(
        {
          HttpHeaders.authorizationHeader: _basicAuthenticationHeaderValue(
            credentials: credentials,
          ),
        },
      );
      return handler.next(options);
    },
  );
}
