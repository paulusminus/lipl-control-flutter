import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/edit_playlist/edit_playlist_cubit.dart';
import 'package:lipl_bloc/l10n/l10n.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';
import 'package:logging/logging.dart';

final Logger log = Logger('$EditPlaylistPage');

class SaveIntent extends Intent {}

class SaveAction extends Action<SaveIntent> {
  SaveAction(this.context, this.isNew);
  final BuildContext context;
  final bool isNew;

  @override
  Object? invoke(SaveIntent intent) async {
    final EditPlaylistState state = context.read<EditPlaylistCubit>().state;
    if (isNew) {
      final PlaylistPost playlistPost = PlaylistPost(
        title: state.title,
        members: state.members
            .map(
              (Lyric lyric) => lyric.id,
            )
            .toList(),
      );
      await context.read<LiplRestCubit>().postPlaylist(playlistPost);
    } else {
      final Playlist playlist = Playlist(
        id: state.id,
        title: state.title,
        members: state.members.map((Lyric lyric) => lyric.id).toList(),
      );
      await context.read<LiplRestCubit>().putPlaylist(playlist);
    }
    context.read<EditPlaylistCubit>().submitted();
    return null;
  }
}

class CloseIntent extends Intent {}

class CloseAction extends Action<CloseIntent> {
  CloseAction(this.context);
  final BuildContext context;

  @override
  Object? invoke(CloseIntent intent) {
    context.read<EditPlaylistCubit>().submitted();
    return null;
  }
}

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
      builder: (BuildContext context) => BlocProvider<EditPlaylistCubit>(
        create: (BuildContext context) => EditPlaylistCubit(
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
    return BlocListener<EditPlaylistCubit, EditPlaylistState>(
      listenWhen: (EditPlaylistState previous, EditPlaylistState current) =>
          previous.status != current.status &&
          current.status == EditPlaylistStatus.succes,
      listener: (BuildContext context, EditPlaylistState state) =>
          Navigator.of(context).pop(),
      child: const EditPlaylistView(),
    );
  }
}

class EditPlaylistView extends StatelessWidget {
  const EditPlaylistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final EditPlaylistStatus status =
        context.select((EditPlaylistCubit cubit) => cubit.state.status);
    final bool isNew =
        context.select((EditPlaylistCubit cubit) => cubit.state.id == null);

    return Shortcuts(
      shortcuts: <SingleActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.keyS, control: true):
            SaveIntent(),
        const SingleActivator(LogicalKeyboardKey.escape): CloseIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          SaveIntent: SaveAction(context, isNew),
          CloseIntent: CloseAction(context),
        },
        child: Builder(
          builder: (BuildContext context) => Focus(
            autofocus: true,
            child: Scaffold(
              appBar: AppBar(
                title: Text(isNew ? l10n.newPlaylist : l10n.editPlaylist),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const <Widget>[
                    _TitleField(),
                    _MembersAddField(),
                    _MembersField(),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: status.isLoadingOrSuccess
                    ? null
                    : Actions.handler(context, SaveIntent()),
                child: status.isLoadingOrSuccess
                    ? const CupertinoActivityIndicator()
                    : const Icon(Icons.save),
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
    final AppLocalizations l10n = context.l10n;
    return BlocBuilder<EditPlaylistCubit, EditPlaylistState>(
      builder: (BuildContext context, EditPlaylistState state) {
        return Form(
          child: TextFormField(
            key: const Key('editPlaylistView_title_textFormField'),
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
              context.read<EditPlaylistCubit>().titleChanged(value);
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
    return BlocBuilder<EditPlaylistCubit, EditPlaylistState>(
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
                  .read<EditPlaylistCubit>()
                  .membersItemDeleted(state.members[index].id);
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
          context.read<EditPlaylistCubit>().membersChanged(oldIndex, newIndex);
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
    final AppLocalizations l10n = context.l10n;
    return BlocBuilder<EditPlaylistCubit, EditPlaylistState>(
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
                decoration: InputDecoration(
                  label: Text(l10n.addLyric),
                ),
                onChanged: (String value) {
                  context.read<EditPlaylistCubit>().searchChanged(value);
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
                        context.read<EditPlaylistCubit>().membersItemAdded(
                              state.filtered[index],
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
