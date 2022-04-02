import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lipl_bloc/app/app.dart';
import 'package:lipl_bloc/edit_lyric/edit_lyric.dart';
import 'package:lipl_bloc/edit_playlist/edit_playlist.dart';
import 'package:lipl_bloc/edit_preferences/edit_preferences.dart';
import 'package:lipl_bloc/play/play.dart';
import 'package:lipl_bloc/widget/widget.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';
import 'package:logging/logging.dart';

final Logger log = Logger('$LyricList');

class LyricList extends StatelessWidget {
  const LyricList();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LiplRestCubit, RestState>(
      builder: (BuildContext context, RestState liplRestState) {
        return BlocBuilder<SelectedTabCubit, SelectedTabState>(
          builder: (BuildContext context, SelectedTabState selectedTabState) =>
              Scaffold(
            appBar: AppBar(
              title: Text(l10n.liplTitle),
              actions: <Widget>[
                if (selectedTabState.selectedTab == SelectedTab.playlists)
                  IconButton(
                    icon: const Icon(Icons.text_snippet),
                    onPressed: () {
                      context.read<SelectedTabCubit>().selectLyrics();
                    },
                  ),
                if (selectedTabState.selectedTab == SelectedTab.lyrics)
                  IconButton(
                    icon: const Icon(Icons.folder),
                    onPressed: () {
                      context.read<SelectedTabCubit>().selectPlaylists();
                    },
                  ),
              ],
            ),
            body: BlocListener<LiplRestCubit, RestState>(
              listenWhen: (RestState previous, RestState current) =>
                  current.status != previous.status,
              listener: (BuildContext context, RestState state) {
                if (state.status == RestStatus.unauthorized) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.unauthorized),
                      action: SnackBarAction(
                        label: l10n.preferences,
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
              child: liplRestState.status == RestStatus.success
                  ? IndexedStack(
                      index: selectedTabState.selectedTab.index,
                      children: <Widget>[
                        renderLyricList(
                          context,
                          liplRestState.lyrics,
                        ),
                        renderPlaylistList(
                          context,
                          liplRestState.playlists,
                          liplRestState.lyrics,
                        ),
                      ],
                    )
                  : const Center(child: CupertinoActivityIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (selectedTabState.selectedTab == SelectedTab.lyrics) {
                  Navigator.of(context).push(
                    EditLyricPage.route(),
                  );
                }
                if (selectedTabState.selectedTab == SelectedTab.playlists) {
                  Navigator.of(context).push(
                    EditPlaylistPage.route(lyrics: liplRestState.lyrics),
                  );
                }
              },
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
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

Widget renderPlaylistSummary(
  BuildContext context,
  Playlist playlist,
  List<Lyric> lyrics,
) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  return ListTile(
    title: Text(l10n.lyrics),
    subtitle: Text(
      playlist.members
          .map(
            (String member) => lyrics
                .firstWhere((Lyric lyric) => lyric.id == member, orElse: null),
          )
          .where(
            (Lyric? lyric) => lyric != null,
          )
          .map((Lyric lyric) => lyric.title)
          .join('\n'),
    ),
  );
}

Widget renderLyricList(BuildContext context, List<Lyric> lyrics) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  return expansionPanelList<Lyric>(
    items: lyrics,
    selectId: selectLyricId,
    selectTitle: renderLyricTitle,
    selectSummary: renderLyricSummary,
    buttons: <ButtonData<Lyric>>[
      ButtonData<Lyric>(
        label: l10n.playButtonLabel,
        onPressed: (Lyric lyric) {
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
        label: l10n.deleteButtonLabel,
        onPressed: (Lyric lyric) async {
          if (await confirm(
            context,
            title: l10n.confirm,
            content: '${l10n.delete} "${lyric.title}"?',
            textOK: l10n.okButtonLabel,
            textCancel: l10n.cancelButtonLabel,
          )) {
            await context.read<LiplRestCubit>().deleteLyric(lyric.id);
          }
        },
      ),
      ButtonData<Lyric>(
        label: l10n.editButtonLabel,
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
}

Widget renderPlaylistList(
  BuildContext context,
  List<Playlist> playlists,
  List<Lyric> lyrics,
) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  return expansionPanelList<Playlist>(
    items: playlists,
    selectId: selectPlaylistId,
    selectTitle: renderPlaylistTitle,
    selectSummary: (Playlist playlist) =>
        renderPlaylistSummary(context, playlist, lyrics),
    buttons: <ButtonData<Playlist>>[
      ButtonData<Playlist>(
        label: l10n.playButtonLabel,
        onPressed: (Playlist playlist) {
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
        label: l10n.deleteButtonLabel,
        onPressed: (Playlist playlist) async {
          if (await confirm(
            context,
            title: l10n.confirm,
            content: '${l10n.delete} "${playlist.title}"?',
            textOK: l10n.okButtonLabel,
            textCancel: l10n.cancelButtonLabel,
          )) {
            await context.read<LiplRestCubit>().deletePlaylist(playlist.id);
          }
        },
      ),
      ButtonData<Playlist>(
        label: l10n.editButtonLabel,
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
}
