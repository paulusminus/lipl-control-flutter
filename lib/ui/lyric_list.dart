import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/data/bloc/data_bloc.dart';
import 'package:lipl_bloc/model/model.dart';

class LyricList extends StatelessWidget {
  const LyricList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
        builder: (BuildContext context, DataState state) {
      return (state.status == DataStatus.success)
          ? ListView(
              children: state
                  .selectedLyrics()
                  .map((Lyric s) => ListTile(
                        title: Text(s.title),
                        trailing: const Icon(Icons.more_vert),
                      ))
                  .toList(),
            )
          : ListView(
              children: const <Widget>[],
            );
    });
  }
}
