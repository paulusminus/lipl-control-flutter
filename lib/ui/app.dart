import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/bloc/bloc.dart';
import 'package:lipl_bloc/dal/dal.dart';
import 'package:lipl_bloc/data/bloc/data_bloc.dart';
import 'package:lipl_bloc/ui/ui.dart';

class AppRepository extends StatelessWidget {
  const AppRepository({
    required Dal dal,
  }) : _dal = dal;

  final Dal _dal;

  @override
  Widget build(BuildContext context) => RepositoryProvider<Dal>.value(
        value: _dal,
        child: AppProvider(),
      );
}

class AppProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: <BlocProvider<Object?>>[
          BlocProvider<SelectedPlaylistCubit>(
            create: (BuildContext context) => SelectedPlaylistCubit(),
          ),
          BlocProvider<DataBloc>(
            create: (BuildContext context) => DataBloc(dal: context.read<Dal>())
              ..add(const DataSubscriptionRequested()),
          )
        ],
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
      home: Summaries(),
    );
  }
}
