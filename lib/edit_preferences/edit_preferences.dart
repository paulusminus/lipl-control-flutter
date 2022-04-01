import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/app/app.dart';
import 'package:preferences_bloc/preferences_bloc.dart';

class EditPreferencesPage extends StatelessWidget {
  const EditPreferencesPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) => const EditPreferencesPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPreferencesBloc<LiplPreferences>,
        EditPreferencesState<LiplPreferences>>(
      builder: (
        BuildContext context,
        EditPreferencesState<LiplPreferences> state,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Voorkeuren'),
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
                    decoration: const InputDecoration(labelText: 'Username'),
                    onChanged: (String value) {
                      context.read<EditPreferencesBloc<LiplPreferences>>().add(
                            EditPreferencesEventChange<LiplPreferences>(
                              preferences:
                                  state.preferences.copyWith(username: value),
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
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    onChanged: (String value) {
                      context.read<EditPreferencesBloc<LiplPreferences>>().add(
                            EditPreferencesEventChange<LiplPreferences>(
                              preferences:
                                  state.preferences.copyWith(password: value),
                            ),
                          );
                    },
                  ),
                  TextFormField(
                    initialValue: state.preferences.baseUrl,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.url,
                    decoration: const InputDecoration(labelText: 'Base Url'),
                    onChanged: (String value) {
                      context.read<EditPreferencesBloc<LiplPreferences>>().add(
                            EditPreferencesEventChange<LiplPreferences>(
                              preferences:
                                  state.preferences.copyWith(baseUrl: value),
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    child: const Text('SAVE'),
                    onPressed: !state.hasChanged
                        ? null
                        : () {
                            context
                                .read<PreferencesBloc<LiplPreferences>>()
                                .add(
                                  PreferencesEventChange<LiplPreferences>(
                                      item: state.preferences),
                                );
                          },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}