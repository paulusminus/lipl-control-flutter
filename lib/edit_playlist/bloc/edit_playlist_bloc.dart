import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';

part 'edit_playlist_event.dart';
part 'edit_playlist_state.dart';

class EditPlaylistBloc extends Bloc<EditPlaylistEvent, EditPlaylistState> {
  EditPlaylistBloc({
    required String? id,
    required String? title,
    required List<Lyric>? members,
    required List<Lyric>? lyrics,
  }) : super(
          EditPlaylistState(
            id: id,
            title: title ?? '',
            members: members ?? <Lyric>[],
            lyrics: lyrics ?? <Lyric>[],
          ),
        ) {
    on<EditPlaylistTitleChanged>(_onTitleChanged);
    on<EditPlaylistSearchChanged>(_onSearchChanged);
    on<EditPlaylistMembersChanged>(_onMembersChanged);
    on<EditPlaylistMembersItemDeleted>(_onMembersItemDeleted);
    on<EditPlaylistMembersItemAdded>(_onMembersItemAdded);
    on<EditPlaylistSubmitted>(_onSubmitted);
  }

  void _onSubmitted(
      EditPlaylistSubmitted event, Emitter<EditPlaylistState> emit) {
    emit(
      state.copyWith(
        status: EditPlaylistStatus.succes,
      ),
    );
  }

  void _onMembersItemDeleted(
    EditPlaylistMembersItemDeleted event,
    Emitter<EditPlaylistState> emit,
  ) {
    emit(
      state.copyWith(
        members: state.members
            .where(
              (Lyric lyric) => lyric.id != event.id,
            )
            .toList(),
      ),
    );
  }

  void _onMembersItemAdded(
    EditPlaylistMembersItemAdded event,
    Emitter<EditPlaylistState> emit,
  ) {
    emit(
      state.copyWith(
          members: <Lyric>[...state.members, event.lyric], search: ''),
    );
  }

  void _onTitleChanged(
    EditPlaylistTitleChanged event,
    Emitter<EditPlaylistState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onSearchChanged(
    EditPlaylistSearchChanged event,
    Emitter<EditPlaylistState> emit,
  ) {
    emit(state.copyWith(search: event.search));
  }

  void _onMembersChanged(
    EditPlaylistMembersChanged event,
    Emitter<EditPlaylistState> emit,
  ) {
    final List<Lyric> members = <Lyric>[...state.members];

    final Lyric removed = members.removeAt(event.oldIndex);
    members.insert(
      event.newIndex < event.oldIndex ? event.newIndex : event.newIndex - 1,
      removed,
    );
    emit(state.copyWith(members: members));
  }
}
