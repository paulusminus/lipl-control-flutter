import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/app/app.dart';
import 'package:lipl_bloc/edit_lyric/edit_lyric.dart';
import 'package:lipl_bloc/edit_playlist/edit_playlist.dart';
import 'package:lipl_bloc/edit_preferences/edit_preferences.dart';
import 'package:lipl_bloc/play/play.dart';
import 'package:lipl_bloc/widget/widget.dart';
import 'package:lipl_repo/lipl_repo.dart';
import 'package:logging/logging.dart';

final Logger log = Logger('$LyricList');

class LyricList extends StatelessWidget {
  const LyricList();

  @override
  Widget build(BuildContext context) => BlocBuilder<AppBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Lipl'),
              actions: <Widget>[
                if (state.selectedTab == SelectedTab.playlists)
                  IconButton(
                    icon: const Icon(Icons.text_snippet),
                    onPressed: () {
                      context.read<AppBloc>().add(
                            const AppTabChanged(
                              tab: SelectedTab.lyrics,
                            ),
                          );
                    },
                  ),
                if (state.selectedTab == SelectedTab.lyrics)
                  IconButton(
                    icon: const Icon(Icons.folder),
                    onPressed: () {
                      context.read<AppBloc>().add(
                            const AppTabChanged(
                              tab: SelectedTab.playlists,
                            ),
                          );
                    },
                  ),
              ],
            ),
            body: BlocListener<AppBloc, AppState>(
              listenWhen: (AppState previous, AppState current) =>
                  current.status != previous.status,
              listener: (BuildContext context, AppState state) {
                if (state.status == AppStatus.noCredentials) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('No Credentials'),
                      action: SnackBarAction(
                        label: 'Voorkeuren',
                        onPressed: () {
                          Navigator.of(context).push(
                            EditPreferencesPage.route(),
                          );
                        },
                      ),
                      duration: const Duration(days: 365),
                    ),
                  );
                }
              },
              child: state.status == AppStatus.success
                  ? IndexedStack(
                      index: state.selectedTab.index,
                      children: <Widget>[
                        renderLyricList(
                          context,
                          state.lyrics,
                        ),
                        renderPlaylistList(
                          context,
                          state.playlists,
                          state.lyrics,
                        ),
                      ],
                    )
                  : const Center(child: CupertinoActivityIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (state.selectedTab == SelectedTab.lyrics) {
                  log.info('Add lyric pressed');
                  Navigator.of(context).push(
                    EditLyricPage.route(),
                  );
                }
                if (state.selectedTab == SelectedTab.playlists) {
                  log.info('Add playlist pressed');
                  Navigator.of(context).push(
                    EditPlaylistPage.route(lyrics: state.lyrics),
                  );
                }
              },
              child: const Icon(Icons.add),
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

Widget renderLyricList(BuildContext context, List<Lyric> lyrics) =>
    expansionPanelList<Lyric>(
      items: lyrics,
      selectId: selectLyricId,
      selectTitle: renderLyricTitle,
      selectSummary: renderLyricSummary,
      buttons: <ButtonData<Lyric>>[
        ButtonData<Lyric>(
          label: 'play',
          onPressed: (Lyric lyric) {
            log.info('Play request Lyric ${lyric.title}');
            Navigator.of(context).push(
              PlayPage.route(
                lyricParts: <Lyric>[lyric].toLyricParts(),
                title: lyric.title,
              ),
            );
          },
          enabled: (Lyric lyric) => lyric.parts.isNotEmpty,
        ),
        ButtonData<Lyric>(
          label: 'delete',
          onPressed: (Lyric lyric) async {
            if (await confirm(
              context,
              title: const Text('Bevestigen'),
              content: Text('${lyric.title} verwijderen?'),
            )) {
              context.read<AppBloc>().add(
                    AppLyricDeletionRequested(
                      id: lyric.id,
                    ),
                  );
            }
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
    );

Widget renderPlaylistList(
        BuildContext context, List<Playlist> playlists, List<Lyric> lyrics) =>
    expansionPanelList<Playlist>(
      items: playlists,
      selectId: selectPlaylistId,
      selectTitle: renderPlaylistTitle,
      selectSummary: (Playlist playlist) =>
          renderPlaylistSummary(playlist, lyrics),
      buttons: <ButtonData<Playlist>>[
        ButtonData<Playlist>(
          label: 'play',
          onPressed: (Playlist playlist) {
            log.info('Playlist play ${playlist.title} requested');
            Navigator.of(context).push(
              PlayPage.route(
                lyricParts: playlist.members
                    .map(
                      (String id) => lyrics.firstWhere(
                        (Lyric lyric) => lyric.id == id,
                        orElse: null,
                      ),
                    )
                    .where(
                      (Lyric? lyric) => lyric != null,
                    )
                    .toList()
                    .toLyricParts(),
                title: playlist.title,
              ),
            );
          },
          enabled: (Playlist playlist) => playlist.members.isNotEmpty,
        ),
        ButtonData<Playlist>(
          label: 'delete',
          onPressed: (Playlist playlist) async {
            if (await confirm(
              context,
              title: const Text('Bevestigen'),
              content: Text('${playlist.title} verwijderen?'),
            )) {
              context.read<AppBloc>().add(
                    AppPlaylistDeletionRequested(
                      id: playlist.id,
                    ),
                  );
            }
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
                        (String lyricId) => lyrics.firstWhere(
                          (Lyric lyric) => lyric.id == lyricId,
                          orElse: null,
                        ),
                      )
                      .where((Lyric? lyric) => lyric != null)
                ],
                lyrics: lyrics,
              ),
            );
          },
        ),
      ],
    );
