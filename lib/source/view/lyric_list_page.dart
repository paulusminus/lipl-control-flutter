import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/edit_lyric/view/edit_lyric_page.dart';
import 'package:lipl_bloc/edit_playlist/view/view.dart';
import 'package:lipl_bloc/source/bloc/source_bloc.dart';
import 'package:lipl_bloc/widget/widget.dart';
import 'package:lipl_repo/lipl_repo.dart';
import 'package:logging/logging.dart';

final Logger log = Logger('$LyricList');

class LyricList extends StatelessWidget {
  const LyricList();

  @override
  Widget build(BuildContext context) => BlocBuilder<SourceBloc, SourceState>(
        builder: (BuildContext context, SourceState state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Lipl'),
              actions: <Widget>[
                PopupMenuButton<String>(
                  icon: const Icon(Icons.add),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuItem<String>>[
                    PopupMenuItem<String>(
                      child: const Text('Tekst'),
                      onTap: () {},
                      value: 'Tekst',
                    ),
                    PopupMenuItem<String>(
                      child: const Text('Afspeelllijst'),
                      onTap: () {},
                      value: 'Afspeellijst',
                    ),
                  ],
                ),
              ],
            ),
            body: (state.status == SourceStatus.success)
                ? SingleChildScrollView(
                    child: IndexedStack(
                      index: state.selectedTab.index,
                      children: <Container>[
                        Container(
                          child: expansionPanelList<Lyric>(
                            items: state.lyrics,
                            selectId: selectLyricId,
                            selectTitle: renderLyricTitle,
                            selectSummary: renderLyricSummary,
                            buttons: <ButtonData<Lyric>>[
                              ButtonData<Lyric>(
                                label: 'delete',
                                onPressed: (Lyric lyric) {
                                  log.info(
                                      'Delete request Lyric ${lyric.title}');
                                },
                              ),
                              ButtonData<Lyric>(
                                label: 'edit',
                                onPressed: (Lyric lyric) {
                                  Navigator.of(context).push(
                                    EditLyricPage.route(
                                      id: lyric.id,
                                      title: lyric.title,
                                      parts: lyric.parts,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: expansionPanelList<Playlist>(
                            items: state.playlists,
                            selectId: selectPlaylistId,
                            selectTitle: renderPlaylistTitle,
                            selectSummary: (Playlist playlist) =>
                                renderPlaylistSummary(playlist, state.lyrics),
                            buttons: <ButtonData<Playlist>>[
                              ButtonData<Playlist>(
                                label: 'delete',
                                onPressed: (Playlist playlist) {
                                  log.info(
                                      'Playlist delete ${playlist.title} requested');
                                },
                              ),
                              ButtonData<Playlist>(
                                label: 'edit',
                                onPressed: (Playlist playlist) {
                                  Navigator.of(context).push(
                                    EditPlaylistPage.route(
                                      id: playlist.id,
                                      title: playlist.title,
                                      members: <Lyric>[
                                        ...playlist.members
                                            .map(
                                              (String lyricId) =>
                                                  state.lyrics.firstWhere(
                                                (Lyric lyric) =>
                                                    lyric.id == lyricId,
                                                orElse: null,
                                              ),
                                            )
                                            .where(
                                                (Lyric? lyric) => lyric != null)
                                      ],
                                      lyrics: state.lyrics,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const CupertinoActivityIndicator(),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.text_snippet),
                    onPressed: () {
                      context.read<SourceBloc>().add(
                            const SourceTabChanged(
                              tab: SelectedTab.lyrics,
                            ),
                          );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      log.info('Add text pressed');
                    },
                    icon: const Icon(Icons.add),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  IconButton(
                    icon: const Icon(Icons.folder),
                    onPressed: () {
                      context.read<SourceBloc>().add(
                            const SourceTabChanged(
                              tab: SelectedTab.playlists,
                            ),
                          );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      log.info('Add playlist pressed');
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          );
        },
      );
}

String selectLyricId(Lyric lyric) => lyric.id;

Widget renderLyricTitle(Lyric lyric) => ListTile(
      title: Text(lyric.title),
      leading: const Icon(Icons.text_snippet_rounded),
    );

Widget renderLyricSummary(Lyric lyric) => ListTile(
      subtitle: Text(
        lyric.parts
            .map(
              (List<String> part) => part.first,
            )
            .join('\n'),
      ),
    );

String selectPlaylistId(Playlist playlist) => playlist.id;

Widget renderPlaylistTitle(Playlist playlist) => ListTile(
      title: Text(playlist.title),
      leading: const Icon(Icons.folder),
    );

Widget renderPlaylistSummary(Playlist playlist, List<Lyric> lyrics) => ListTile(
      title: const Text('Teksten'),
      subtitle: Text(
        playlist.members
            .map(
              (String member) => lyrics.firstWhere(
                  (Lyric lyric) => lyric.id == member,
                  orElse: null),
            )
            .where(
              (Lyric? lyric) => lyric != null,
            )
            .map((Lyric lyric) => lyric.title)
            .join('\n'),
      ),
    );
