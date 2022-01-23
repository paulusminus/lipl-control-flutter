import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/bloc/bloc.dart';
import 'package:lipl_bloc/model/model.dart';
import 'package:lipl_bloc/ui/ui.dart';

class Summaries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FullCubit fullCubit = BlocProvider.of<FullCubit>(context);
    fullCubit.load();

    return BlocBuilder<FullCubit, FullState>(
        builder: (BuildContext context, FullState summariesState) {
      return Scaffold(
        appBar: AppBar(title: const Text('Lipl'), actions: <Widget>[
          DropdownButton<String>(
            onChanged: (String? value) {
              debugPrint(value);
            },
            value: '',
            icon: const Icon(Icons.arrow_downward),
            items: <DropdownMenuItem<String>>[
              const DropdownMenuItem<String>(child: Text('Alles'), value: ''),
              ...summariesState.playlists
                  .map((Playlist p) => DropdownMenuItem<String>(
                        child: Text(p.title),
                        value: p.id,
                      ))
                  .toList()
            ],
          ),
        ]),
        drawer: Drawer(
          child: PlaylistSummariesList(summariesState),
        ),
        body: LyricList(summariesState),
      );
    });
  }
}
