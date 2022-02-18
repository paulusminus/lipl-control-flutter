import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_repo/lipl_repo.dart';

part 'edit_playlist_event.dart';
part 'edit_playlist_state.dart';

class EditPlaylistBloc extends Bloc<EditPlaylistEvent, EditPlaylistState> {
  EditPlaylistBloc({
    required LiplRestStorage liplRestStorage,
    required String? id,
    required String? title,
    required List<Summary>? members,
  })  : _liplRestStorage = liplRestStorage,
        super(
          EditPlaylistState(
            id: id,
            title: title ?? '',
            members: members ?? <Summary>[],
          ),
        ) {
    on<EditPlaylistTitleChanged>(_onTitleChanged);
    on<EditPlaylistMembersChanged>(_onMembersChanged);
    on<EditPlaylistSubmitted>(_onSubmitted);
    on<EditPlaylistMembersItemDeleted>(_onMembersItemDeleted);
  }
  final LiplRestStorage _liplRestStorage;

  void _onMembersItemDeleted(
    EditPlaylistMembersItemDeleted event,
    Emitter<EditPlaylistState> emit,
  ) {
    emit(
      state.copyWith(
        members: state.members
            .where((Summary summary) => summary.id != event.id)
            .toList(),
      ),
    );
  }

  void _onTitleChanged(
    EditPlaylistTitleChanged event,
    Emitter<EditPlaylistState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onMembersChanged(
    EditPlaylistMembersChanged event,
    Emitter<EditPlaylistState> emit,
  ) {
    final List<Summary> members = <Summary>[...state.members];
    final Summary removed = members.removeAt(event.oldIndex);
    members.insert(event.newIndex, removed);
    emit(state.copyWith(members: members));
  }

  Future<void> _onSubmitted(
    EditPlaylistSubmitted event,
    Emitter<EditPlaylistState> emit,
  ) async {
    if (state.isNewLyric) {
      final PlaylistPost playlistPost = PlaylistPost(
        title: state.title,
        members: state.members.map((Summary summary) => summary.id).toList(),
      );
      final Playlist postedPlaylist =
          await _liplRestStorage.postPlaylist(playlistPost);
      emit(
        state.copyWith(
          status: EditPlaylistStatus.succes,
          id: postedPlaylist.id,
          title: postedPlaylist.title,
          members: postedPlaylist.members
              .map(
                (String memberId) => state.members.firstWhere(
                  (Summary summary) => summary.id == memberId,
                  orElse: null,
                ),
              )
              .where(
                (Summary? summary) => summary != null,
              )
              .toList(),
        ),
      );
    } else {
      final Playlist playlist = Playlist(
        id: state.id,
        title: state.title,
        members: state.members.map((Summary summary) => summary.id).toList(),
      );
      final Playlist puttedPlaylist =
          await _liplRestStorage.putPlaylist(playlist);
      emit(
        state.copyWith(
          status: EditPlaylistStatus.succes,
          id: puttedPlaylist.id,
          title: puttedPlaylist.title,
          members: puttedPlaylist.members
              .map(
                (String memberId) => state.members.firstWhere(
                  (Summary summary) => summary.id == memberId,
                  orElse: null,
                ),
              )
              .where(
                (Summary? summary) => summary != null,
              )
              .toList(),
        ),
      );
    }
  }
}
