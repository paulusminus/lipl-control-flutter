import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/data/bloc/data_bloc.dart';
import 'package:lipl_bloc/ui/ui.dart';

class Summaries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
        builder: (BuildContext context, DataState state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Lipl'),
          actions: <Widget>[
            PlaylistFilter(),
          ],
        ),
        drawer: const Drawer(
          child: PlaylistSummariesList(),
        ),
        body: const LyricList(),
      );
    });
  }
}
