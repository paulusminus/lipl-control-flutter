import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';

enum EditPlaylistStatus { initial, loading, succes, failure }

extension EditPlaylistStatusX on EditPlaylistStatus {
  bool get isLoadingOrSuccess => <EditPlaylistStatus>[
        EditPlaylistStatus.loading,
        EditPlaylistStatus.succes,
      ].contains(this);
}

class EditPlaylistState extends Equatable {
  const EditPlaylistState({
    this.status = EditPlaylistStatus.initial,
    this.id,
    this.title = '',
    this.search = '',
    this.members = const <Lyric>[],
    this.lyrics = const <Lyric>[],
  });

  final EditPlaylistStatus status;
  final String? id;
  final String title;
  final String search;
  final List<Lyric> members;
  final List<Lyric> lyrics;

  bool get isNewLyric => id == null;

  List<Lyric> get filtered => lyrics
      .where(
        (Lyric lyric) =>
            lyric.title.toLowerCase().contains(search.toLowerCase()),
      )
      .toList();

  EditPlaylistState copyWith({
    EditPlaylistStatus? status,
    String? id,
    String? title,
    String? search,
    List<Lyric>? members,
  }) =>
      EditPlaylistState(
        status: status ?? this.status,
        id: id ?? this.id,
        title: title ?? this.title,
        search: search ?? this.search,
        members: members ?? this.members,
        lyrics: lyrics,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        id,
        title,
        search,
        members,
        lyrics,
      ];
}

class EditPlaylistCubit extends Cubit<EditPlaylistState> {
  EditPlaylistCubit({
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
        );

  void submitted() {
    emit(
      state.copyWith(
        status: EditPlaylistStatus.succes,
      ),
    );
  }

  void membersItemDeleted(String id) {
    emit(
      state.copyWith(
        members: state.members
            .where(
              (Lyric lyric) => lyric.id != id,
            )
            .toList(),
      ),
    );
  }

  void membersItemAdded(Lyric lyric) {
    emit(
      state.copyWith(members: <Lyric>[...state.members, lyric], search: ''),
    );
  }

  void titleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void searchChanged(String search) {
    emit(state.copyWith(search: search));
  }

  void membersChanged(int oldIndex, int newIndex) {
    final List<Lyric> members = <Lyric>[...state.members];

    final Lyric removed = members.removeAt(oldIndex);
    members.insert(
      newIndex < oldIndex ? newIndex : newIndex - 1,
      removed,
    );
    emit(state.copyWith(members: members));
  }
}
