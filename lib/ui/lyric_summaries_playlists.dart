import 'package:flutter/material.dart';
import 'package:lipl_test/bloc/bloc.dart';
import 'package:lipl_test/model/model.dart';

class PlaylistSummariesList extends StatelessWidget {
  const PlaylistSummariesList(this.fullState);

  final FullState fullState;

  @override
  Widget build(BuildContext context) {
    return (fullState.status == Status.loaded)
        ? Column(
            children: <Widget>[
              const ListTile(
                title: Text('Playlists'),
              ),
              ListView(
                shrinkWrap: true,
                children: fullState.playlists
                    .map((Playlist p) => ListTile(
                          title: Text(p.title),
                          subtitle: Text(p.members.join(', ')),
                        ))
                    .toList(),
              ),
            ],
          )
        : Column(
            children: const <Widget>[],
          );
  }
}
