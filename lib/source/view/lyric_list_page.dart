import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/edit_lyric/view/edit_lyric_page.dart';
import 'package:lipl_bloc/source/bloc/source_bloc.dart';
import 'package:lipl_bloc/source/view/view.dart';
import 'package:lipl_repo/lipl_repo.dart';

class LyricList extends StatelessWidget {
  const LyricList();

  @override
  Widget build(BuildContext context) => BlocBuilder<SourceBloc, SourceState>(
        builder: (BuildContext context, SourceState state) {
          final List<Expandable<Lyric>> lyrics = state.selectedLyrics();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Lipl'),
              actions: <Widget>[
                PlaylistDropdown(
                    onSelectPlaylist: (Playlist? playlist) {
                      context
                          .read<SourceBloc>()
                          .add(SourcePlaylistSelected(playlist: playlist));
                    },
                    playlists: state.playlists,
                    selectedPlaylist: state.selectedPlaylist)
              ],
            ),
            body: (state.status == SourceStatus.success)
                ? SingleChildScrollView(
                    child: Container(
                      child: ExpansionPanelList(
                        expansionCallback: (int panelIndex, bool isExpanded) {
                          final SourceLyricToggleExpanded event =
                              SourceLyricToggleExpanded(
                            id: lyrics[panelIndex].data.id,
                          );
                          context.read<SourceBloc>().add(event);
                        },
                        children: lyrics
                            .map(
                              (Expandable<Lyric> lyric) => ExpansionPanel(
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) =>
                                        ListTile(
                                  title: Text(lyric.data.title),
                                  leading: const Icon(Icons.text_snippet_sharp),
                                ),
                                body: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: const Text('Samenvatting'),
                                      subtitle: Text(lyric.data.parts
                                          .map((List<String> s) =>
                                              s.first + '...')
                                          .join('\n')),
                                    ),
                                    TextButton.icon(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {},
                                      label: const Text('Verwijder'),
                                    ),
                                    TextButton.icon(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          EditLyricPage.route(
                                            id: lyric.data.id,
                                            title: lyric.data.title,
                                            parts: lyric.data.parts,
                                          ),
                                        );
                                      },
                                      label: const Text('Wijzig'),
                                    ),
                                  ],
                                ),
                                isExpanded: lyric.expanded,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                : const CupertinoActivityIndicator(),
          );
        },
      );
}
