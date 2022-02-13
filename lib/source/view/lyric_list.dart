import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/source/bloc/source_bloc.dart';
import 'package:lipl_repo/lipl_repo.dart';

class LyricList extends StatelessWidget {
  const LyricList();

  @override
  Widget build(BuildContext context) => BlocBuilder<SourceBloc, SourceState>(
        builder: (BuildContext context, SourceState state) {
          final List<Expandable<Lyric>> lyrics = state.selectedLyrics();
          return (state.status == SourceStatus.success)
              ? SingleChildScrollView(
                  child: Container(
                    child: ExpansionPanelList(
                      expansionCallback: (int panelIndex, bool isExpanded) {
                        context.read<SourceBloc>().add(
                            SourceLyricToggleExpanded(
                                id: lyrics[panelIndex].data.id));
                      },
                      children: lyrics
                          .map(
                            (Expandable<Lyric> lyric) => ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) =>
                                      ListTile(title: Text(lyric.data.title)),
                              body: Text(lyric.data.parts
                                  .map((List<String> s) => s.join('\n'))
                                  .join('\n\n')),
                              isExpanded: lyric.expanded,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
              : const CupertinoActivityIndicator();
        },
      );
}
