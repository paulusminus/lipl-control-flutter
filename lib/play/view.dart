import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';
import 'play.dart';

final Logger log = Logger('$PlayPage');

class PreviousIntent extends Intent {}

class PreviousAction extends Action<PreviousIntent> {
  PreviousAction({required this.controller});
  final PageController controller;
  @override
  Object? invoke(PreviousIntent intent) async {
    await controller.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    return null;
  }
}

class NextIntent extends Intent {}

class NextAction extends Action<NextIntent> {
  NextAction({required this.controller});
  final PageController controller;

  @override
  Object? invoke(NextIntent intent) async {
    await controller.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    return null;
  }
}

class HomeIntent extends Intent {}

class HomeAction extends Action<HomeIntent> {
  HomeAction({required this.controller});
  final PageController controller;

  @override
  Object? invoke(HomeIntent intent) async {
    await controller.animateToPage(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    return null;
  }
}

class EndIntent extends Intent {}

class EndAction extends Action<EndIntent> {
  EndAction({required this.controller, required this.count});
  final PageController controller;
  final int count;

  @override
  Object? invoke(EndIntent intent) async {
    await controller.animateToPage(
      count - 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    return null;
  }
}

class CloseIntent extends Intent {}

class CloseAction extends Action<CloseIntent> {
  CloseAction({required this.context});
  final BuildContext context;

  @override
  Object? invoke(CloseIntent intent) {
    Navigator.of(context).pop();
    return null;
  }
}

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
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final PageController controller = PageController();
    return Shortcuts(
      shortcuts: <SingleActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.arrowLeft): PreviousIntent(),
        const SingleActivator(LogicalKeyboardKey.arrowRight): NextIntent(),
        const SingleActivator(LogicalKeyboardKey.home): HomeIntent(),
        const SingleActivator(LogicalKeyboardKey.end): EndIntent(),
        const SingleActivator(LogicalKeyboardKey.escape): CloseIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          PreviousIntent: PreviousAction(controller: controller),
          NextIntent: NextAction(controller: controller),
          HomeIntent: HomeAction(controller: controller),
          EndIntent:
              EndAction(controller: controller, count: lyricParts.length),
          CloseIntent: CloseAction(context: context),
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('${l10n.playPageTitle} $title'),
          ),
          body: Focus(
            autofocus: true,
            child: PageView(
                controller: controller,
                children: lyricParts
                    .map(
                      (LyricPart lyricPart) => Center(
                        child: RichText(
                          text: TextSpan(
                            text: lyricPart.text,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              height: 1.2,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '\n\n${lyricPart.title} (${lyricPart.current} / ${lyricPart.total})',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black,
                                  height: 1.2,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList()),
          ),
        ),
      ),
    );
  }
}
