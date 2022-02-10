import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/data/bloc/data_bloc.dart';
import 'package:lipl_bloc/model/model.dart';

class PlaylistFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
        builder: (BuildContext context, DataState state) {
      return DropdownButton<Playlist?>(
        onChanged: (Playlist? playlist) {
          debugPrint(playlist?.title);
          context.read<DataBloc>().add(DataPlaylistSelected(playlist));
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
