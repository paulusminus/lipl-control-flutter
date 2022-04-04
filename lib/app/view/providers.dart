import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lipl_bloc/app/app.dart';
import 'package:lipl_bloc/l10n/l10n.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';
import 'package:logging/logging.dart';
import 'package:preferences_bloc/preferences_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Logger blocProvidersLog = Logger('$BlocProviders');

class LiplPreferences extends Equatable {
  const LiplPreferences({
    required this.username,
    required this.password,
    required this.baseUrl,
  });

  factory LiplPreferences.deserialize(String s) {
    final dynamic json = jsonDecode(s);
    return LiplPreferences(
      username: json['username'],
      password: json['password'],
      baseUrl: json['base_url'],
    );
  }

  factory LiplPreferences.blank() => const LiplPreferences(
        username: '',
        password: '',
        baseUrl: '',
      );

  final String username;
  final String password;
  final String baseUrl;

  String serialize() => jsonEncode(
        <String, dynamic>{
          'username': username,
          'password': password,
          'base_url': baseUrl
        },
      );

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

  @override
  List<Object?> get props => <Object?>[username, password, baseUrl];
}

class PersistSharedPreferences<T> implements Persist<T> {
  PersistSharedPreferences({
    required this.key,
    required this.deserialize,
    required this.serialize,
  });
  final String key;
  final T Function(String) deserialize;
  final String Function(T) serialize;

  @override
  Future<T?> load() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? s = preferences.getString(key);
    return s == null ? null : deserialize(s);
  }

  @override
  Future<void> save(T? t) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (t == null) {
      preferences.remove(key);
    } else {
      await preferences.setString(key, serialize(t));
    }
  }
}

class BlocProviders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PreferencesBloc<LiplPreferences> preferencesBloc =
        PreferencesBloc<LiplPreferences>(
      persist: PersistSharedPreferences<LiplPreferences>(
        deserialize: LiplPreferences.deserialize,
        serialize: (LiplPreferences preferences) => preferences.serialize(),
        key: '$LiplPreferences',
      ),
    );

    final LiplRestCubit liplRestCubit = LiplRestCubit();
    preferencesBloc.stream
        .where(
          (PreferencesState<LiplPreferences> preferences) =>
              preferences.status == PreferencesStatus.succes,
        )
        .distinct()
        .listen(
      (PreferencesState<LiplPreferences> preferences) async {
        final Credentials? credentials = preferences.item == null
            ? null
            : preferences.item!.username.isEmpty ||
                    preferences.item!.password.isEmpty
                ? null
                : Credentials(
                    username: preferences.item!.username,
                    password: preferences.item!.password,
                  );
        await liplRestCubit.load(
          apiFromConfig(
            credentials: credentials,
            baseUrl: preferences.item?.baseUrl,
          ),
        );
      },
    );

    preferencesBloc.add(PreferencesEventLoad<LiplPreferences>());

    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<PreferencesBloc<LiplPreferences>>(
          create: (_) => preferencesBloc,
        ),
        BlocProvider<EditPreferencesBloc<LiplPreferences>>(
          create: (_) => EditPreferencesBloc<LiplPreferences>(
            changes: preferencesBloc.stream,
            defaultValue: LiplPreferences.blank(),
          ),
        ),
        BlocProvider<LiplRestCubit>(create: (_) => liplRestCubit),
        BlocProvider<SelectedTabCubit>(
          create: (_) => SelectedTabCubit(),
        ),
      ],
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lipl',
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('nl'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<PreferencesBloc<LiplPreferences>,
          PreferencesState<LiplPreferences>>(
        builder:
            (BuildContext context, PreferencesState<LiplPreferences> state) =>
                state.status == PreferencesStatus.succes
                    ? const LyricList()
                    : const Center(
                        child: CupertinoActivityIndicator(),
                      ),
      ),
    );
  }
}
