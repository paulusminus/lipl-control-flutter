import 'package:flutter/material.dart';
import 'package:lipl_repo/lipl_repo.dart';

class PlaylistDropdown extends StatelessWidget {
  const PlaylistDropdown({
    required this.onSelectPlaylist,
    required this.playlists,
    required this.selectedPlaylist,
  });
  final void Function(Playlist?) onSelectPlaylist;
  final List<Playlist> playlists;
  final Playlist? selectedPlaylist;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Playlist?>(
      onChanged: onSelectPlaylist,
      value: selectedPlaylist,
      icon: const Icon(Icons.arrow_downward),
      style: const TextStyle(color: Colors.white),
      dropdownColor: Colors.blue,
      iconEnabledColor: Colors.white,
      items: <DropdownMenuItem<Playlist?>>[
        const DropdownMenuItem<Playlist?>(
          child: Text('Alles'),
          value: null,
        ),
        ...playlists
            .map(
              (Playlist playlist) => DropdownMenuItem<Playlist?>(
                child: Text(playlist.title),
                value: playlist,
              ),
            )
            .toList()
      ],
    );
  }
}
