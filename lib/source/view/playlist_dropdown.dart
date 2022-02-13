import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/source/bloc/source_bloc.dart';
import 'package:lipl_repo/lipl_repo.dart';

class PlaylistDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourceBloc, SourceState>(
        builder: (BuildContext context, SourceState state) {
      return DropdownButton<Playlist?>(
        onChanged: (Playlist? playlist) {
          debugPrint(playlist?.title);
          context
              .read<SourceBloc>()
              .add(SourcePlaylistSelected(playlist: playlist));
        },
        value: state.selectedPlaylist,
        icon: const Icon(Icons.arrow_downward),
        items: <DropdownMenuItem<Playlist?>>[
          const DropdownMenuItem<Playlist?>(child: Text('Alles'), value: null),
          ...state.playlists
              .map(
                (Playlist playlist) => DropdownMenuItem<Playlist?>(
                  child: Text(playlist.title),
                  value: playlist,
                ),
              )
              .toList()
        ],
      );
    });
  }
}
