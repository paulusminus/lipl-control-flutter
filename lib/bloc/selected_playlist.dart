import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class SelectedPlaylistState extends Equatable {
  const SelectedPlaylistState({required this.active, required this.key});

  final bool active;
  final String key;

  @override
  List<Object> get props => <Object>[active, key];
}

SelectedPlaylistState filter(String s) =>
    SelectedPlaylistState(active: true, key: s);

SelectedPlaylistState noFilter() =>
    const SelectedPlaylistState(active: false, key: '');

class SelectedPlaylistCubit extends Cubit<SelectedPlaylistState> {
  SelectedPlaylistCubit() : super(noFilter());

  void select(String key) => emit(filter(key));

  void clear() => emit(noFilter());
}
