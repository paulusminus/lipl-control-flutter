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
                        final SourceLyricToggleExpanded event =
                            SourceLyricToggleExpanded(
                          id: lyrics[panelIndex].data.id,
                        );
                        context.read<SourceBloc>().add(event);
                      },
                      children: lyrics
                          .map(
                            (Expandable<Lyric> lyric) => ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) =>
                                      ListTile(
                                title: Text(lyric.data.title),
                                leading: const Icon(Icons.text_snippet_sharp),
                              ),
                              body: Column(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Samenvatting',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      Text(lyric.data.parts
                                          .map((List<String> s) =>
                                              s.first + '...')
                                          .join('\n')),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      TextButton.icon(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {},
                                        label: const Text('Verwijder'),
                                      ),
                                      TextButton.icon(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {},
                                        label: const Text('Wijzig'),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              ),
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
