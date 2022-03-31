import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lipl_bloc/app/view/providers.dart';
import 'package:lipl_bloc/bloc_observer.dart';
import 'package:logging/logging.dart';

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

  BlocOverrides.runZoned(
    () {
      runApp(
        BlocProviders(),
      );
    },
    blocObserver: LiplBlocObserver(),
  );
}
