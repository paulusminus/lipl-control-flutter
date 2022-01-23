import 'package:flutter/material.dart';
import 'package:lipl_test/bloc/bloc.dart';
import 'package:lipl_test/model/model.dart';

class LyricList extends StatelessWidget {
  const LyricList(this.fullState);

  final FullState fullState;

  @override
  Widget build(BuildContext context) {
    return (fullState.status == Status.loaded)
        ? ListView(
            children: fullState.lyrics
                .map((Lyric s) => ListTile(
                      title: Text(s.title),
                      trailing: const Icon(Icons.more_vert),
                    ))
                .toList(),
          )
        : ListView(
            children: const <Widget>[],
          );
  }
}
