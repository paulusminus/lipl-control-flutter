part of 'edit_playlist_bloc.dart';

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
    this.members = const <Summary>[],
  });

  final EditPlaylistStatus status;
  final String? id;
  final String title;
  final List<Summary> members;

  bool get isNewLyric => id == null;

  EditPlaylistState copyWith({
    EditPlaylistStatus? status,
    String? id,
    String? title,
    List<Summary>? members,
  }) =>
      EditPlaylistState(
        status: status ?? this.status,
        id: id ?? this.id,
        title: title ?? this.title,
        members: members ?? this.members,
      );

  @override
  List<Object?> get props => <Object?>[status, id, title, members];
}
