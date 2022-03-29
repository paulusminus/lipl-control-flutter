import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/app/view/view.dart';
import 'package:lipl_preferences_bloc/lipl_preferences_bloc.dart';

class PreferencesProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LiplPreferencesBloc>(
      create: (BuildContext context) => LiplPreferencesBloc(),
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Competitie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<LiplPreferencesBloc, LiplPreferencesState>(
        builder: (BuildContext context, LiplPreferencesState state) =>
            state.status == LiplPreferencesStatus.succes
                ? const LyricList()
                : const Center(
                    child: CupertinoActivityIndicator(),
                  ),
      ),
    );
  }
}
