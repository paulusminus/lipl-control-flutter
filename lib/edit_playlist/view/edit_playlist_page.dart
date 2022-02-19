import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/edit_playlist/bloc/edit_playlist_bloc.dart';
import 'package:lipl_repo/lipl_repo.dart';
import 'package:logging/logging.dart';

final Logger log = Logger('$EditPlaylistPage');

class EditPlaylistPage extends StatelessWidget {
  const EditPlaylistPage({Key? key}) : super(key: key);

  static Route<void> route({
    String? id,
    String? title,
    List<Lyric>? members,
    List<Lyric>? lyrics,
  }) {
    return MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) => BlocProvider<EditPlaylistBloc>(
        create: (BuildContext context) => EditPlaylistBloc(
          liplRestStorage: context.read<LiplRestStorage>(),
          id: id,
          title: title,
          members: members,
          lyrics: lyrics,
        ),
        child: const EditPlaylistPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditPlaylistBloc, EditPlaylistState>(
      listenWhen: (EditPlaylistState previous, EditPlaylistState current) =>
          previous.status != current.status &&
          current.status == EditPlaylistStatus.succes,
      listener: (BuildContext context, EditPlaylistState state) =>
          Navigator.of(context).pop(),
      child: const EditLyricView(),
    );
  }
}

class EditLyricView extends StatelessWidget {
  const EditLyricView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditPlaylistStatus status =
        context.select((EditPlaylistBloc bloc) => bloc.state.status);
    final bool isNew =
        context.select((EditPlaylistBloc bloc) => bloc.state.id == null);

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? 'Nieuwe tekst' : 'Wijzigen tekst'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context
                .read<EditPlaylistBloc>()
                .add(const EditPlaylistSubmitted()),
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
              _MembersField(),
              _MembersAddField(),
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
    return BlocBuilder<EditPlaylistBloc, EditPlaylistState>(
      builder: (BuildContext context, EditPlaylistState state) {
        return TextFormField(
          key: const Key('editPlaylistView_title_textFormField'),
          initialValue: state.title,
          decoration: InputDecoration(
            enabled: !state.status.isLoadingOrSuccess,
            labelText: 'Titel',
            hintText: state.title,
          ),
          maxLength: 50,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(50),
          ],
          onChanged: (String value) {
            context
                .read<EditPlaylistBloc>()
                .add(EditPlaylistTitleChanged(value));
          },
        );
      },
    );
  }
}

class _MembersField extends StatelessWidget {
  const _MembersField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPlaylistBloc, EditPlaylistState>(
      builder: (BuildContext context, EditPlaylistState state) {
        return ReorderableListView(
          key: const Key('editPlaylistView_members_reordableFormField'),
          shrinkWrap: true,
          children: state.members
              .map(
                (Summary summary) => Dismissible(
                  key: Key('editPlaylistView_members_item_${summary.id}'),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      context
                          .read<EditPlaylistBloc>()
                          .add(EditPlaylistMembersItemDeleted(summary.id));
                    }
                  },
                  child: ListTile(
                    title: Text(summary.title),
                  ),
                ),
              )
              .toList(),
          onReorder: (int oldIndex, int newIndex) {
            context.read<EditPlaylistBloc>().add(
                  EditPlaylistMembersChanged(oldIndex, newIndex),
                );
          },
        );
      },
    );
  }
}

class _MembersAddField extends StatelessWidget {
  const _MembersAddField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPlaylistBloc, EditPlaylistState>(
      builder: (BuildContext context, EditPlaylistState state) =>
          Autocomplete<Lyric>(
        displayStringForOption: (Summary option) => option.title,
        optionsBuilder: (
          TextEditingValue textEditingValue,
        ) {
          if (textEditingValue.text.trim() == '') {
            return const Iterable<Lyric>.empty();
          }
          return state.lyrics.where(
            (Lyric lyric) => lyric.title.toLowerCase().contains(
                  textEditingValue.text.toLowerCase(),
                ),
          );
        },
        fieldViewBuilder: (
          BuildContext context,
          TextEditingController textEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted,
        ) {
          return TextFormField(
            key: const Key('editPlaylistView_members_addFormField'),
            controller: textEditingController,
            focusNode: fieldFocusNode,
            decoration: const InputDecoration(
              labelText: 'Toevoegen',
            ),
            onFieldSubmitted: (String value) {
              log.info('Value $value submitted');
              // textEditingController.clear();
              onFieldSubmitted();
            },
          );
        },
        onSelected: (Lyric lyric) {
          context.read<EditPlaylistBloc>().add(
                EditPlaylistMembersItemAdded(lyric),
              );
        },
      ),
    );
  }
}
