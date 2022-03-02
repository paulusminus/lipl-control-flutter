import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lipl_bloc/app/app.dart';
import 'package:lipl_bloc/bloc_observer.dart';
import 'package:lipl_repo/lipl_repo.dart';
import 'package:logging/logging.dart';
import 'package:preferences_local_storage/preferences_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid && kDebugMode) {
    final ByteData data =
        await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
    SecurityContext.defaultContext
        .setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  // await sharedPreferences.setString(
  //     'credentials', '{"username":"$USERNAME","password":"$PASSWORD"}');

  BlocOverrides.runZoned(
    () {
      runApp(
        AppRepository(
          preferencesLocalStorage: PreferencesLocalStorage<Credentials>(
            serializer: (Credentials c) => c.toJson().toString(),
            deserializer: (String s) => Credentials.fromJson(jsonDecode(s)),
            key: 'credentials',
            sharedPreferences: sharedPreferences,
          ),
        ),
      );
    },
    blocObserver: LiplBlocObserver(),
  );
}
