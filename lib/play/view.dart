import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'play.dart';

final Logger log = Logger('$PlayPage');

class PlayPage extends StatelessWidget {
  const PlayPage({Key? key, required this.lyricParts, required this.title})
      : super(key: key);
  final String title;
  final List<LyricPart> lyricParts;

  static Route<void> route({
    required List<LyricPart> lyricParts,
    required String title,
  }) {
    return MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) => PlayPage(
        lyricParts: lyricParts,
        title: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Afspelen $title'),
      ),
      body: PageView(
          onPageChanged: (int pageno) {
            final LyricPart page = lyricParts[pageno];
            log.info('Page ${page.title} (${page.current} / ${page.total})');
          },
          children: lyricParts
              .map(
                (LyricPart lyricPart) => Center(
                  child: ListTile(
                    title: Text(
                        '${lyricPart.title} (${lyricPart.current} / ${lyricPart.total})'),
                    subtitle: Text(lyricPart.text),
                  ),
                ),
              )
              .toList()),
    );
  }
}
