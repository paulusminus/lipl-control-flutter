part of 'edit_playlist_bloc.dart';

abstract class EditPlaylistEvent {
  const EditPlaylistEvent();
}

class EditPlaylistTitleChanged extends EditPlaylistEvent {
  const EditPlaylistTitleChanged(this.title);

  final String title;
}

class EditPlaylistSearchChanged extends EditPlaylistEvent {
  const EditPlaylistSearchChanged(this.search);

  final String search;
}

class EditPlaylistMembersItemDeleted extends EditPlaylistEvent {
  const EditPlaylistMembersItemDeleted(this.id);
  final String id;
}

class EditPlaylistMembersItemAdded extends EditPlaylistEvent {
  const EditPlaylistMembersItemAdded(this.lyric);
  final Lyric lyric;
}

class EditPlaylistMembersChanged extends EditPlaylistEvent {
  const EditPlaylistMembersChanged(this.oldIndex, this.newIndex);

  final int oldIndex;
  final int newIndex;
}

class EditPlaylistSubmitted extends EditPlaylistEvent {
  const EditPlaylistSubmitted();
}
