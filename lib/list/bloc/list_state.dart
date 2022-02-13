part of 'list_bloc.dart';

class ListState extends Equatable {
  const ListState({required this.lyrics});

  final List<Expandable<Lyric>> lyrics;

  @override
  List<Object?> get props => <Object?>[];
}
