import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_test/bloc/bloc.dart';
import 'package:lipl_test/dal/dal.dart';
import 'package:lipl_test/ui/ui.dart';

class App extends StatelessWidget {
  const App({required this.dal});

  final Dal dal;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Competitie',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: <BlocProvider<Cubit<Object>>>[
            BlocProvider<FullCubit>(
              create: (BuildContext context) => FullCubit(dal: dal),
            ),
            BlocProvider<SelectedPlaylistCubit>(
                create: (BuildContext context) => SelectedPlaylistCubit()),
          ],
          child: Summaries(),
        ));
  }
}
