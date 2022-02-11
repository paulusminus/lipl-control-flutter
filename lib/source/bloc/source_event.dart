part of 'source_bloc.dart';

abstract class SourceEvent extends Equatable {
  const SourceEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class SourceSubscriptionRequested extends SourceEvent {
  const SourceSubscriptionRequested();
}

class SourcePlaylistSelected extends SourceEvent {
  const SourcePlaylistSelected(this.playlist);
  final Playlist? playlist;

  @override
  List<Object?> get props => <Object?>[playlist];
}
