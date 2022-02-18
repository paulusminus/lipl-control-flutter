part of 'source_bloc.dart';

abstract class SourceEvent extends Equatable {
  const SourceEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class SourceSubscriptionRequested extends SourceEvent {
  const SourceSubscriptionRequested();
}

class SourceTabChanged extends SourceEvent {
  const SourceTabChanged({required this.tab});
  final SelectedTab tab;

  @override
  List<Object?> get props => <Object?>[tab];
}

class SourcePlaylistSelected extends SourceEvent {
  const SourcePlaylistSelected({required this.playlist});
  final Playlist? playlist;

  @override
  List<Object?> get props => <Object?>[playlist];
}
