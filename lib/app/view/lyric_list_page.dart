import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_ble/lipl_ble.dart';
import 'package:lipl_bloc/app/app.dart';
import 'package:lipl_bloc/edit_lyric/edit_lyric.dart';
import 'package:lipl_bloc/edit_playlist/edit_playlist.dart';
import 'package:lipl_bloc/edit_preferences/edit_preferences.dart';
import 'package:lipl_bloc/l10n/l10n.dart';
import 'package:lipl_bloc/play/play.dart';
import 'package:lipl_bloc/search/search_view.dart';
import 'package:lipl_bloc/select_display_server/select_display_server.dart';
import 'package:lipl_bloc/widget/widget.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

void Function(BuildContext, RestState) onRestUnauthorized(
  AppLocalizations l10n,
) =>
    (BuildContext context, RestState state) {
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
    };

class LyricList extends StatelessWidget {
  const LyricList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        leading: const PreferencesButton(),
        title: Text(l10n.liplTitle),
        actions: <Widget>[
          const SearchButton(),
          if (context.isMobile) const BluetoothIndicator(),
          SelectTabButton(),
        ],
      ),
      body: BlocListener<LiplRestCubit, RestState>(
        listenWhen: (RestState previous, RestState current) =>
            current.status != previous.status,
        listener: onRestUnauthorized(l10n),
        child: const LyricsOrPlaylistsView(),
      ),
      floatingActionButton: const AddNewFloatingActionButton(),
    );
  }
}

class LyricsOrPlaylistsView extends StatelessWidget {
  const LyricsOrPlaylistsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedTabCubit, SelectedTab>(
      builder: (BuildContext context, SelectedTab state) {
        return IndexedStack(
          index: state.index,
          children: <Widget>[
            renderLyricList(
              context.read<LiplRestCubit>().lyricsStream,
            ),
            renderPlaylistList(),
          ],
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
  final AppLocalizations l10n = context.l10n;
  return ListTile(
    title: Text(l10n.lyrics),
    subtitle: Text(
      playlist.members
          .map(
            (String member) => lyrics.cast<Lyric?>().firstWhere(
                (Lyric? lyric) => lyric?.id == member,
                orElse: () => null),
          )
          .where(
            (Lyric? lyric) => lyric != null,
          )
          .map((Lyric? lyric) => lyric!.title)
          .join('\n'),
    ),
  );
}

Widget renderLyricList(Stream<List<Lyric>> lyricsStream) {
  return StreamBuilder<List<Lyric>>(
    stream: lyricsStream,
    builder: (BuildContext context, AsyncSnapshot<List<Lyric>> lyrics) {
      final AppLocalizations l10n = context.l10n;
      final LiplRestCubit liplRestCubit = context.read<LiplRestCubit>();

      if (lyrics.data == null) {
        return const SizedBox.shrink();
      } else {
        return expansionPanelList<Lyric>(
          items: lyrics.data!,
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
              onPressed: (Lyric lyric) {
                confirm(
                  context,
                  title: l10n.confirm,
                  content: '${l10n.delete} "${lyric.title}"?',
                  textOK: l10n.okButtonLabel,
                  textCancel: l10n.cancelButtonLabel,
                ).then((result) => {
                      if (result) {liplRestCubit.deleteLyric(lyric.id)}
                    });
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
    },
  );
}

Widget renderPlaylistList() {
  return BlocBuilder<LiplRestCubit, RestState>(
    builder: (BuildContext context, RestState state) {
      final AppLocalizations l10n = context.l10n;
      return expansionPanelList<Playlist>(
        items: state.playlists,
        selectId: selectPlaylistId,
        selectTitle: renderPlaylistTitle,
        selectSummary: (Playlist playlist) =>
            renderPlaylistSummary(context, playlist, state.lyrics),
        buttons: <ButtonData<Playlist>>[
          ButtonData<Playlist>(
            label: l10n.playButtonLabel,
            onPressed: (Playlist playlist) {
              Navigator.of(context).push(
                PlayPage.route(
                  lyricParts: playlist.members
                      .map(
                        (String id) => state.lyrics.cast<Lyric?>().firstWhere(
                              (Lyric? lyric) => lyric?.id == id,
                              orElse: () => null,
                            ),
                      )
                      .where(
                        (Lyric? lyric) => lyric != null,
                      )
                      .cast<Lyric>()
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
              final LiplRestCubit liplRestCubit = context.read<LiplRestCubit>();
              final confirmDialog = confirm(
                context,
                title: l10n.confirm,
                content: '${l10n.delete} "${playlist.title}"?',
                textOK: l10n.okButtonLabel,
                textCancel: l10n.cancelButtonLabel,
              );
              if (await confirmDialog) {
                await liplRestCubit.deletePlaylist(playlist.id);
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
                          (String lyricId) =>
                              state.lyrics.cast<Lyric?>().firstWhere(
                                    (Lyric? lyric) => lyric?.id == lyricId,
                                    orElse: () => null,
                                  ),
                        )
                        .where((Lyric? lyric) => lyric != null)
                        .cast<Lyric>()
                  ],
                ),
              );
            },
          ),
        ],
      );
    },
  );
}

class BluetoothIndicator extends StatelessWidget {
  const BluetoothIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BleScanCubit, BleScanState>(
      builder: (BuildContext context, BleScanState state) => IconButton(
        onPressed: () async {
          final BleScanCubit bleScanCubit = context.read<BleScanCubit>();
          if (context.isMobile && !state.permissionGranted) {
            if (await Permission.bluetooth.request() ==
                    PermissionStatus.granted &&
                await Permission.location.request() ==
                    PermissionStatus.granted) {
              bleScanCubit.permissionGranted();
            }
          }
          if (context.mounted) {
            await bleScanCubit.start();
          }
          if (context.mounted) {
            Navigator.of(context).push(SelectDisplayServerPage.route());
          }
        },
        icon: BlocBuilder<BleConnectionCubit, BleConnectionState>(
          builder: (BuildContext context, BleConnectionState state) {
            return BlocBuilder<BleConnectionCubit, BleConnectionState>(
              builder: (BuildContext context, BleConnectionState state) {
                return Icon(
                  state.isConnected
                      ? Icons.bluetooth_connected
                      : Icons.bluetooth,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class SelectTabButton extends StatelessWidget {
  SelectTabButton({Key? key}) : super(key: key);

  final Map<SelectedTab, IconData> whichIcon = <SelectedTab, IconData>{
    SelectedTab.lyrics: Icons.folder,
    SelectedTab.playlists: Icons.text_snippet,
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedTabCubit, SelectedTab>(
        builder: (BuildContext context, SelectedTab state) {
      return IconButton(
        onPressed: () {
          if (state == SelectedTab.lyrics) {
            context.read<SelectedTabCubit>().selectPlaylists();
          }
          if (state == SelectedTab.playlists) {
            context.read<SelectedTabCubit>().selectLyrics();
          }
        },
        icon: Icon(
          whichIcon[state],
        ),
      );
    });
  }
}

class AddNewFloatingActionButton extends StatelessWidget {
  const AddNewFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedTabCubit, SelectedTab>(
      builder: (BuildContext context, SelectedTab state) {
        return FloatingActionButton(
          onPressed: () {
            if (state == SelectedTab.lyrics) {
              Navigator.of(context).push(
                EditLyricPage.route(),
              );
            }
            if (state == SelectedTab.playlists) {
              Navigator.of(context).push(
                EditPlaylistPage.route(),
              );
            }
          },
          child: const Icon(Icons.add),
        );
      },
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiplRestCubit, RestState>(
      builder: (BuildContext context, RestState state) {
        return state.lyrics.length > 20
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).push(SearchPage.route());
                },
                icon: const Icon(Icons.search))
            : const SizedBox.shrink();
      },
    );
  }
}

class PreferencesButton extends StatelessWidget {
  const PreferencesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(EditPreferencesPage.route());
      },
      icon: const Icon(Icons.settings),
    );
  }
}
