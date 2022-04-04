import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lipl_bloc/l10n/l10n.dart';
import 'package:logging/logging.dart';
import 'play.dart';

final Logger log = Logger('$PlayPage');

class PreviousIntent extends Intent {}

class PreviousAction extends Action<PreviousIntent> {
  PreviousAction(this.controller);
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
  NextAction(this.controller);
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
  HomeAction(this.controller);
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
  EndAction(this.controller, this.count);
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
  CloseAction(this.context);
  final BuildContext context;

  @override
  Object? invoke(CloseIntent intent) {
    Navigator.of(context).pop();
    return null;
  }
}

class PlayPage extends StatefulWidget {
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
  State<StatefulWidget> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final PageController controller = PageController();

    final PreviousIntent previousIntent = PreviousIntent();
    final NextIntent nextIntent = NextIntent();
    final HomeIntent homeIntent = HomeIntent();
    final EndIntent endIntent = EndIntent();
    final CloseIntent closeIntent = CloseIntent();

    return Shortcuts(
      shortcuts: <SingleActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.arrowLeft): previousIntent,
        const SingleActivator(LogicalKeyboardKey.arrowRight): nextIntent,
        const SingleActivator(LogicalKeyboardKey.home): homeIntent,
        const SingleActivator(LogicalKeyboardKey.end): endIntent,
        const SingleActivator(LogicalKeyboardKey.escape): closeIntent,
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          PreviousIntent: PreviousAction(controller),
          NextIntent: NextAction(controller),
          HomeIntent: HomeAction(controller),
          EndIntent: EndAction(controller, widget.lyricParts.length),
          CloseIntent: CloseAction(context),
        },
        child: Builder(
          builder: (BuildContext context) => Focus(
            autofocus: true,
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: PageView(
                  controller: controller,
                  onPageChanged: (int page) {
                    setState(
                      () {
                        current = page;
                      },
                    );
                  },
                  children: widget.lyricParts
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
                                      '\n\n\n${lyricPart.title} (${lyricPart.current} / ${lyricPart.total})',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
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
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.grey.shade200,
                fixedColor: Colors.black,
                unselectedItemColor: Colors.black,
                showUnselectedLabels: true,
                onTap: (int index) {
                  Function()? createHandler<T extends Intent>(T t) =>
                      Actions.handler<T>(context, t);
                  <Function()?>[
                    createHandler(homeIntent),
                    createHandler(previousIntent),
                    createHandler(nextIntent),
                    createHandler(endIntent),
                  ][index]
                      ?.call();
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.first_page),
                    label: l10n.first,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.keyboard_arrow_left),
                    label: l10n.previous,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.keyboard_arrow_right),
                    label: l10n.next,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.last_page),
                    label: l10n.last,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
