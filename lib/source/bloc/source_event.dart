part of 'source_bloc.dart';

abstract class SourceEvent extends Equatable {
  const SourceEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class SourceSubscriptionRequested extends SourceEvent {
  const SourceSubscriptionRequested();
}

class SourceLyricToggleExpanded extends SourceEvent {
  const SourceLyricToggleExpanded({required this.id});
  final String id;

  @override
  List<Object?> get props => <Object?>[id];
}

class SourcePlaylistSelected extends SourceEvent {
  const SourcePlaylistSelected({required this.playlist});
  final Playlist? playlist;

  @override
  List<Object?> get props => <Object?>[playlist];
}
