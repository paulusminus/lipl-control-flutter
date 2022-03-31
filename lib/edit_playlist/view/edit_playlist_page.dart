import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/edit_playlist/bloc/edit_playlist_bloc.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';
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
        title: Text(isNew ? 'Nieuwe afspeellijst' : 'Wijzigen afspeellijst'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: status.isLoadingOrSuccess
            ? null
            : () {
                final EditPlaylistState state =
                    context.read<EditPlaylistBloc>().state;
                if (state.isNewLyric) {
                  final PlaylistPost playlistPost = PlaylistPost(
                      title: state.title,
                      members: state.members
                          .map(
                            (Lyric lyric) => lyric.title,
                          )
                          .toList());
                  context.read<LiplRestBloc>().add(
                      LiplRestEventPostPlaylist(playlistPost: playlistPost));
                } else {
                  final Playlist playlist = Playlist(
                    id: state.id,
                    title: state.title,
                    members: state.members
                        .map((Lyric lyric) => lyric.title)
                        .toList(),
                  );
                  context
                      .read<LiplRestBloc>()
                      .add(LiplRestEventPutPlaylist(playlist: playlist));
                }
                context
                    .read<EditPlaylistBloc>()
                    .add(const EditPlaylistSubmitted());
              },
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const <Widget>[
            _TitleField(),
            _MembersAddField(),
            _MembersField(),
            SizedBox(
              height: 60.0,
            ),
          ],
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
        return Form(
          child: TextFormField(
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
          ),
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
      return ReorderableListView.builder(
        buildDefaultDragHandles: false,
        key: const Key('editPlaylistView_members_reordableFormField'),
        shrinkWrap: true,
        itemCount: state.members.length,
        itemBuilder: (BuildContext context, int index) => Dismissible(
          key: Key('editPlaylistView_members_item_${state.members[index].id}'),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              context
                  .read<EditPlaylistBloc>()
                  .add(EditPlaylistMembersItemDeleted(state.members[index].id));
            }
          },
          child: ListTile(
            leading: ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.drag_indicator),
            ),
            title: Text(state.members[index].title),
          ),
        ),
        onReorder: (int oldIndex, int newIndex) {
          context.read<EditPlaylistBloc>().add(
                EditPlaylistMembersChanged(oldIndex, newIndex),
              );
        },
      );
    });
  }
}

class _MembersAddField extends StatefulWidget {
  const _MembersAddField({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MembersAddFieldState();
}

class _MembersAddFieldState extends State<_MembersAddField> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPlaylistBloc, EditPlaylistState>(
      builder: (BuildContext context, EditPlaylistState state) {
        return Form(
          key: _globalKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                key: const Key('__autocomplete_lyric__textFormField'),
                keyboardType: TextInputType.text,
                focusNode: _focusNode,
                initialValue: '',
                autocorrect: false,
                enableSuggestions: false,
                enableIMEPersonalizedLearning: false,
                decoration: const InputDecoration(
                  label: Text('Tekst toevoegen'),
                ),
                onChanged: (String value) {
                  context
                      .read<EditPlaylistBloc>()
                      .add(EditPlaylistSearchChanged(value));
                },
              ),
              if (state.filtered.isNotEmpty && state.filtered.length <= 3)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.filtered.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(state.filtered[index].title),
                      onTap: () {
                        context.read<EditPlaylistBloc>().add(
                              EditPlaylistMembersItemAdded(
                                state.filtered[index],
                              ),
                            );
                        _globalKey.currentState?.reset();
                        _focusNode.requestFocus();
                      },
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
