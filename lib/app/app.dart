import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/source/bloc/source_bloc.dart';
import 'package:lipl_bloc/source/view/view.dart';
import 'package:lipl_repo/lipl_repo.dart';
import 'package:rxdart/rxdart.dart';

class AppRepository extends StatelessWidget {
  const AppRepository();

  @override
  Widget build(BuildContext context) {
    final Credentials credentials = Credentials(
      username: 'paul',
      password: 'CumGranoSalis',
    );

    final ValueStream<Credentials> stream =
        BehaviorSubject<Credentials>.seeded(credentials).stream;
    return RepositoryProvider<LiplRestStorage>.value(
      value: LiplRestStorage(stream.listen((_) {})),
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
