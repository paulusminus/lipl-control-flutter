import 'package:flutter/material.dart';
import 'package:lipl_repo/lipl_repo.dart';

class PlaylistPopup extends StatelessWidget {
  const PlaylistPopup({
    required this.onSelectPlaylist,
    required this.playlists,
    required this.selectedPlaylist,
  });
  final void Function(Playlist?) onSelectPlaylist;
  final List<Playlist> playlists;
  final Playlist? selectedPlaylist;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.redAccent,
            Colors.blueAccent,
            Colors.purpleAccent,
          ],
        ),
      ),
      child: DropdownButton<Playlist?>(
        style: const TextStyle(color: Colors.white),
        dropdownColor: Colors.white,
        iconEnabledColor: Colors.white,
        underline: Container(),
        onChanged: onSelectPlaylist,
        value: selectedPlaylist,
        icon: const Icon(Icons.arrow_downward),
        items: <DropdownMenuItem<Playlist?>>[
          const DropdownMenuItem<Playlist?>(child: Text('Alles'), value: null),
          ...playlists
              .map(
                (Playlist playlist) => DropdownMenuItem<Playlist?>(
                  child: Text(playlist.title),
                  value: playlist,
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
