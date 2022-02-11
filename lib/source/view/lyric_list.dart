import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/model/model.dart';
import 'package:lipl_bloc/source/bloc/source_bloc.dart';

class LyricList extends StatelessWidget {
  const LyricList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourceBloc, SourceState>(
        builder: (BuildContext context, SourceState state) {
      return (state.status == SourceStatus.success)
          ? ListView(
              children: state
                  .selectedLyrics()
                  .map((Lyric s) => ListTile(
                        title: Text(s.title),
                        trailing: const Icon(Icons.more_vert),
                      ))
                  .toList(),
            )
          : ListView(
              children: const <Widget>[],
            );
    });
  }
}
