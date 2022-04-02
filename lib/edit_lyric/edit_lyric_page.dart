import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';
import 'package:parts/parts.dart';
import 'edit_lyric_cubit.dart';

class CloseIntent extends Intent {}

class CloseAction extends Action<CloseIntent> {
  CloseAction({required this.context});
  final BuildContext context;
  @override
  Object? invoke(CloseIntent intent) {
    context.read<EditLyricCubit>().submitted();
    return null;
  }
}

class SaveIntent extends Intent {}

class SaveAction extends Action<SaveIntent> {
  SaveAction({required this.context});
  final BuildContext context;

  @override
  Object? invoke(SaveIntent intent) async {
    final LiplRestCubit liplRestCubit = context.read<LiplRestCubit>();
    final EditLyricState state = context.read<EditLyricCubit>().state;
    if (state.isNew) {
      await liplRestCubit.postLyric(
        LyricPost(
          title: state.title,
          parts: toParts(state.text),
        ),
      );
    } else {
      await liplRestCubit.putLyric(
        Lyric(
          id: state.id,
          title: state.title,
          parts: toParts(state.text),
        ),
      );
    }
    return null;
  }
}

class EditLyricPage extends StatelessWidget {
  const EditLyricPage({Key? key}) : super(key: key);

  static Route<void> route(
      {String? id, String? title, List<List<String>>? parts}) {
    return MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) => BlocProvider<EditLyricCubit>(
        create: (BuildContext context) => EditLyricCubit(
          id: id,
          title: title,
          parts: parts,
        ),
        child: const EditLyricPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditLyricCubit, EditLyricState>(
      listenWhen: (EditLyricState previous, EditLyricState current) =>
          previous.status != current.status &&
          current.status == EditLyricStatus.succes,
      listener: (BuildContext context, EditLyricState state) =>
          Navigator.of(context).pop(),
      child: const EditLyricView(),
    );
  }
}

class EditLyricView extends StatelessWidget {
  const EditLyricView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final EditLyricStatus status =
        context.select((EditLyricCubit cubit) => cubit.state.status);
    final bool isNew =
        context.select((EditLyricCubit cubit) => cubit.state.id == null);

    return Shortcuts(
      shortcuts: <SingleActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.keyS, control: true):
            SaveIntent(),
        const SingleActivator(LogicalKeyboardKey.escape): CloseIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          SaveIntent: SaveAction(context: context),
          CloseIntent: CloseAction(context: context),
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(isNew ? l10n.newLyric : l10n.editLyric),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: status.isLoadingOrSuccess
                ? null
                : Actions.handler(context, SaveIntent()),
            child: status.isLoadingOrSuccess
                ? const CupertinoActivityIndicator()
                : const Icon(Icons.save),
          ),
          body: Focus(
            autofocus: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const <Widget>[
                    _TitleField(),
                    _TextField(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return BlocBuilder<EditLyricCubit, EditLyricState>(
      builder: (BuildContext context, EditLyricState state) {
        return TextFormField(
          key: const Key('editLyricView_title_textFormField'),
          initialValue: state.title,
          decoration: InputDecoration(
            enabled: !state.status.isLoadingOrSuccess,
            labelText: l10n.titleLabel,
            hintText: state.title,
          ),
          maxLength: 50,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(50),
          ],
          onChanged: (String value) {
            context.read<EditLyricCubit>().titleChanged(value);
          },
        );
      },
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return BlocBuilder<EditLyricCubit, EditLyricState>(
      builder: (BuildContext context, EditLyricState state) {
        return TextFormField(
          key: const Key('editLyricView_text_textFormField'),
          maxLines: null,
          initialValue: state.text,
          decoration: InputDecoration(
            enabled: !state.status.isLoadingOrSuccess,
            labelText: l10n.textLabel,
            hintText: state.text,
          ),
          onChanged: (String value) {
            context.read<EditLyricCubit>().textChanged(value);
          },
        );
      },
    );
  }
}
