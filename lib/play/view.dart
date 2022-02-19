import 'package:flutter/material.dart';
import 'play.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({Key? key, required this.lyricParts}) : super(key: key);
  final List<LyricPart> lyricParts;

  static Route<void> route({
    required List<LyricPart> lyricParts,
  }) {
    return MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) => PlayPage(
        lyricParts: lyricParts,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Afspelen'),
      ),
      body: PageView(
          controller: controller,
          children: lyricParts
              .map(
                (LyricPart lyricPart) => Center(
                  child: ListTile(
                    title: Text(
                        '${lyricPart.title} (${lyricPart.current} / ${lyricPart.total}}'),
                    subtitle: Text(lyricPart.text),
                  ),
                ),
              )
              .toList()),
    );
  }
}
