import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/source/bloc/source_bloc.dart';
import 'package:lipl_bloc/source/view/view.dart';

class Summaries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourceBloc, SourceState>(
        builder: (BuildContext context, SourceState state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Lipl'),
          actions: <Widget>[
            PlaylistDropdown(),
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
