import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/source/bloc/source_bloc.dart';
import 'package:lipl_bloc/source/view/view.dart';
import 'package:lipl_repo/lipl_repo.dart';
import 'package:preferences_local_storage/preferences_local_storage.dart';

class AppRepository extends StatelessWidget {
  const AppRepository({required this.preferencesLocalStorage});

  final PreferencesLocalStorage<Credentials> preferencesLocalStorage;

  @override
  Widget build(BuildContext context) {
    final LiplRestStorage liplRestStorage = LiplRestStorage(
      preferencesLocalStorage.get().listen((_) {}),
    );

    return MultiRepositoryProvider(
      providers: <RepositoryProvider<Object>>[
        RepositoryProvider<LiplRestStorage>.value(
          value: liplRestStorage,
        ),
        RepositoryProvider<PreferencesLocalStorage<Credentials>>.value(
          value: preferencesLocalStorage,
        )
      ],
      child: AppProvider(),
    );
  }
}

class AppProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<SourceBloc>(
        create: (BuildContext context) =>
            SourceBloc(liplRestStorage: context.read<LiplRestStorage>())
              ..add(const SourceSubscriptionRequested()),
        child: App(),
      );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Competitie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LyricList(),
    );
  }
}
