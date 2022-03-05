import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_repo/lipl_repo.dart';
import 'package:preferences_local_storage/preferences_local_storage.dart';
import '../bloc/preferences_bloc.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) => BlocProvider<PreferencesBloc>(
        create: (BuildContext context) => PreferencesBloc(
          preferencesLocalStorage:
              context.read<PreferencesLocalStorage<Credentials>>(),
        ),
        child: const PreferencesPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreferencesBloc, PreferencesState>(
      listenWhen: (PreferencesState previous, PreferencesState current) =>
          previous.status != current.status &&
          current.status == PreferencesStatus.success,
      listener: (BuildContext context, PreferencesState state) =>
          Navigator.of(context).pop(),
      child: const PreferencesView(),
    );
  }
}

class PreferencesView extends StatelessWidget {
  const PreferencesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PreferencesStatus status =
        context.select((PreferencesBloc bloc) => bloc.state.status);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voorkeuren'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: status != PreferencesStatus.initial
            ? null
            : () => context
                .read<PreferencesBloc>()
                .add(PreferencesEventSubmitted()),
        child: status != PreferencesStatus.initial
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const <Widget>[
              _UsernameField(),
              _PasswordField(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsernameField extends StatelessWidget {
  const _UsernameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (BuildContext context, PreferencesState state) {
        return TextFormField(
          key: const Key('editPreferencesView_username_textFormField'),
          initialValue: state.username,
          decoration: InputDecoration(
            enabled: state.status == PreferencesStatus.initial,
            labelText: 'Gebruikersnaam',
            hintText: state.username,
          ),
          maxLength: 50,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(50),
          ],
          onChanged: (String value) {
            context.read<PreferencesBloc>().add(
                  PreferencesEventUsernameChanged(username: value),
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
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (BuildContext context, PreferencesState state) {
        return TextFormField(
          key: const Key('editPreferencesView_password_textFormField'),
          initialValue: state.password,
          decoration: InputDecoration(
            enabled: state.status == PreferencesStatus.initial,
            labelText: 'Wachtwoord',
            hintText: state.password,
          ),
          obscureText: true,
          maxLength: 50,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(50),
          ],
          onChanged: (String value) {
            context.read<PreferencesBloc>().add(
                  PreferencesEventPasswordChanged(password: value),
                );
          },
        );
      },
    );
  }
}
