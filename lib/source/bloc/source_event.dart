part of 'source_bloc.dart';

abstract class SourceEvent {
  const SourceEvent();
}

class SourceSubscriptionRequested extends SourceEvent {
  const SourceSubscriptionRequested();
}

class SourceTabChanged extends SourceEvent {
  const SourceTabChanged({required this.tab});
  final SelectedTab tab;
}

class SourcePlaylistSelected extends SourceEvent {
  const SourcePlaylistSelected({required this.playlist});
  final Playlist? playlist;
}

class SourcePlaylistDeletionRequested extends SourceEvent {
  const SourcePlaylistDeletionRequested({required this.id});
  final String id;
}

class SourceLyricDeletionRequested extends SourceEvent {
  const SourceLyricDeletionRequested({required this.id});
  final String id;
}
