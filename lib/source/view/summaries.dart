import 'package:flutter/material.dart';
import 'package:lipl_bloc/source/view/view.dart';

class Summaries extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Lipl'),
          actions: <Widget>[
            PlaylistDropdown(),
          ],
        ),
        body: const LyricList(),
      );
}
