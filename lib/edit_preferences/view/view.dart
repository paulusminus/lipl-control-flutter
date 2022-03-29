import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/edit_preferences/bloc/edit_preferences_bloc.dart';
import 'package:lipl_preferences_bloc/lipl_preferences_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voorkeuren'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final EditPreferencesState state =
              context.read<EditPreferencesBloc>().state;
          context
              .read<LiplPreferencesBloc>()
              .add(LiplPreferencesEventAllChanged(
                username: state.username,
                password: state.password,
                baseUrl: state.baseUrl,
              ));
        },
        child: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const <Widget>[
              _BaseUrlField(),
              _UsernameField(),
              _PasswordField(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BaseUrlField extends StatelessWidget {
  const _BaseUrlField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPreferencesBloc, EditPreferencesState>(
      builder: (BuildContext context, EditPreferencesState state) {
        return TextFormField(
          key: const Key('editPreferencesView_baseUrl_textFormField'),
          initialValue: state.baseUrl,
          decoration: InputDecoration(
            enabled: state.status == EditPreferencesStatus.initial,
            labelText: 'Api prefix',
            hintText: state.baseUrl,
          ),
          maxLength: 50,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(50),
          ],
          onChanged: (String value) {
            context.read<EditPreferencesBloc>().add(
                  EditPreferencesEventUsernameChanged(username: value),
                );
          },
        );
      },
    );
  }
}

class _UsernameField extends StatelessWidget {
  const _UsernameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPreferencesBloc, EditPreferencesState>(
      builder: (BuildContext context, EditPreferencesState state) {
        return TextFormField(
          key: const Key('editPreferencesView_username_textFormField'),
          initialValue: state.username,
          decoration: InputDecoration(
            enabled: state.status == EditPreferencesStatus.initial,
            labelText: 'Gebruikersnaam',
            hintText: state.username,
          ),
          maxLength: 50,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(50),
          ],
          onChanged: (String value) {
            context.read<EditPreferencesBloc>().add(
                  EditPreferencesEventUsernameChanged(username: value),
                );
          },
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPreferencesBloc, EditPreferencesState>(
      builder: (BuildContext context, EditPreferencesState state) {
        return TextFormField(
          key: const Key('editPreferencesView_password_textFormField'),
          initialValue: state.password,
          decoration: InputDecoration(
            enabled: state.status == EditPreferencesStatus.initial,
            labelText: 'Wachtwoord',
            hintText: state.password,
          ),
          obscureText: true,
          maxLength: 50,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(50),
          ],
          onChanged: (String value) {
            context.read<EditPreferencesBloc>().add(
                  EditPreferencesEventPasswordChanged(password: value),
                );
          },
        );
      },
    );
  }
}
