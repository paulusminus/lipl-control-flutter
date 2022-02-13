part of 'list_bloc.dart';

abstract class ListEvent extends Equatable {}

class ListItemToggleExpanded extends ListEvent {
  ListItemToggleExpanded({required this.id});

  final String id;

  @override
  List<Object?> get props => <Object?>[id];
}

class ListSourceChanged extends ListEvent {
  ListSourceChanged({required this.lyrics});
  final List<Expandable<Lyric>> lyrics;

  @override
  List<Object?> get props => <Object?>[lyrics];
}
