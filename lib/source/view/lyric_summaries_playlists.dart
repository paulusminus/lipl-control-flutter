import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/model/model.dart';
import 'package:lipl_bloc/source/bloc/source_bloc.dart';

class PlaylistSummariesList extends StatelessWidget {
  const PlaylistSummariesList();

  @override
  Widget build(BuildContext context) => BlocBuilder<SourceBloc, SourceState>(
        builder: (
          BuildContext context,
          SourceState state,
        ) =>
            state.status == SourceStatus.success
                ? Column(
                    children: <Widget>[
                      const ListTile(
                        title: Text('Playlists'),
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: state.playlists
                            .map(
                              (Playlist playlist) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Text>[
                                    Text(
                                      playlist.title,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    ...state
                                        .lyricTitles(playlist)
                                        .map((String title) => Text(title)),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  )
                : Column(
                    children: const <Widget>[],
                  ),
      );
}
