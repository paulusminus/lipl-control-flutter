part of 'edit_playlist_bloc.dart';

abstract class EditPlaylistEvent extends Equatable {
  const EditPlaylistEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class EditPlaylistTitleChanged extends EditPlaylistEvent {
  const EditPlaylistTitleChanged(this.title);

  final String title;

  @override
  List<Object?> get props => <Object?>[title];
}

class EditPlaylistMembersItemDeleted extends EditPlaylistEvent {
  const EditPlaylistMembersItemDeleted(this.id);
  final String id;
}

class EditPlaylistMembersChanged extends EditPlaylistEvent {
  const EditPlaylistMembersChanged(this.oldIndex, this.newIndex);

  final int oldIndex;
  final int newIndex;

  @override
  List<Object?> get props => <Object?>[oldIndex, newIndex];
}

class EditPlaylistSubmitted extends EditPlaylistEvent {
  const EditPlaylistSubmitted();
}
