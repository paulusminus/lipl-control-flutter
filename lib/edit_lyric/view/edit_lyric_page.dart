import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';
import 'package:parts/parts.dart';
import '../bloc/edit_lyric_bloc.dart';

class EditLyricPage extends StatelessWidget {
  const EditLyricPage({Key? key}) : super(key: key);

  static Route<void> route(
      {String? id, String? title, List<List<String>>? parts}) {
    return MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) => BlocProvider<EditLyricBloc>(
        create: (BuildContext context) => EditLyricBloc(
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
    return BlocListener<EditLyricBloc, EditLyricState>(
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
        context.select((EditLyricBloc bloc) => bloc.state.status);
    final bool isNew =
        context.select((EditLyricBloc bloc) => bloc.state.id == null);

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? l10n.newLyric : l10n.editLyric),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: status.isLoadingOrSuccess
            ? null
            : () {
                final LiplRestBloc liplRestBloc = context.read<LiplRestBloc>();
                final EditLyricState state =
                    context.read<EditLyricBloc>().state;
                if (isNew) {
                  liplRestBloc.add(
                    LiplRestEventPostLyric(
                      lyricPost: LyricPost(
                        title: state.title,
                        parts: toParts(state.text),
                      ),
                    ),
                  );
                } else {
                  liplRestBloc.add(
                    LiplRestEventPutLyric(
                      lyric: Lyric(
                        id: state.id,
                        title: state.title,
                        parts: toParts(state.text),
                      ),
                    ),
                  );
                }
                context.read<EditLyricBloc>().add(const EditLyricSubmitted());
              },
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
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
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return BlocBuilder<EditLyricBloc, EditLyricState>(
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
            context.read<EditLyricBloc>().add(EditLyricTitleChanged(value));
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
    return BlocBuilder<EditLyricBloc, EditLyricState>(
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
            context.read<EditLyricBloc>().add(
                  EditLyricTextChanged(value),
                );
          },
        );
      },
    );
  }
}
