import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/app/app.dart';
import 'package:lipl_bloc/l10n/l10n.dart';
import 'package:preferences_bloc/preferences_bloc.dart';

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

class SaveIntent extends Intent {}

class SaveAction extends Action<SaveIntent> {
  SaveAction(this.context);
  final BuildContext context;

  @override
  Object? invoke(SaveIntent intent) {
    final LiplPreferences item =
        context.read<EditPreferencesBloc<LiplPreferences>>().state.preferences;
    context.read<PreferencesBloc<LiplPreferences>>().add(
          PreferencesEventChange<LiplPreferences>(
            item: item,
          ),
        );
    Navigator.of(context).pop();
    return null;
  }
}

// TODO(paul): EditPreferencesPage not initialized with shared preferences
class EditPreferencesPage extends StatelessWidget {
  const EditPreferencesPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) =>
          BlocProvider<EditPreferencesBloc<LiplPreferences>>(
        create: (BuildContext context) => EditPreferencesBloc<LiplPreferences>(
          changes: context.read<PreferencesBloc<LiplPreferences>>().stream,
          defaultValue: LiplPreferences.blank(),
        ),
        child: const EditPreferencesPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => const EditPreferencesView();
}

class EditPreferencesView extends StatelessWidget {
  const EditPreferencesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Shortcuts(
      shortcuts: <SingleActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.keyS, control: true):
            SaveIntent(),
        const SingleActivator(LogicalKeyboardKey.escape): CloseIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          SaveIntent: SaveAction(context),
          CloseIntent: CloseAction(context),
        },
        child: Builder(builder: (BuildContext context) {
          return Focus(
            autofocus: true,
            child: BlocBuilder<EditPreferencesBloc<LiplPreferences>,
                EditPreferencesState<LiplPreferences>>(
              builder: (
                BuildContext context,
                EditPreferencesState<LiplPreferences> state,
              ) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(l10n.preferences),
                  ),
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            initialValue: state.preferences.username,
                            enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(labelText: l10n.usernameLabel),
                            onChanged: (String value) {
                              context
                                  .read<EditPreferencesBloc<LiplPreferences>>()
                                  .add(
                                    EditPreferencesEventChange<LiplPreferences>(
                                      preferences: state.preferences
                                          .copyWith(username: value),
                                    ),
                                  );
                            },
                          ),
                          TextFormField(
                            initialValue: state.preferences.password,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: l10n.passwordLabel,
                            ),
                            onChanged: (String value) {
                              context
                                  .read<EditPreferencesBloc<LiplPreferences>>()
                                  .add(
                                    EditPreferencesEventChange<LiplPreferences>(
                                      preferences: state.preferences
                                          .copyWith(password: value),
                                    ),
                                  );
                            },
                          ),
                          TextFormField(
                            initialValue: state.preferences.baseUrl,
                            enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.url,
                            decoration:
                                InputDecoration(labelText: l10n.baseUrlLabel),
                            onChanged: (String value) {
                              context
                                  .read<EditPreferencesBloc<LiplPreferences>>()
                                  .add(
                                    EditPreferencesEventChange<LiplPreferences>(
                                      preferences: state.preferences
                                          .copyWith(baseUrl: value),
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: state.hasChanged
                        ? Actions.handler(context, SaveIntent())
                        : null,
                    child: const Icon(Icons.save),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
