import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';

class SearchState extends Equatable {
  const SearchState({required this.searchTerm, required this.lyrics});
  final String searchTerm;
  final List<Lyric> lyrics;

  List<Lyric> get searchResult => searchTerm.trim().length < 3
      ? <Lyric>[]
      : lyrics
          .where((Lyric lyric) =>
              lyric.title.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

  @override
  List<Object?> get props => <Object?>[searchTerm, lyrics];
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(Stream<List<Lyric>> stream)
      : super(const SearchState(searchTerm: '', lyrics: <Lyric>[])) {
    _subscription = stream.distinct().listen((List<Lyric> lyrics) {
      emit(SearchState(searchTerm: state.searchTerm, lyrics: lyrics));
    });
  }

  late StreamSubscription<void> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }

  void search(String value) {
    emit(SearchState(searchTerm: value, lyrics: state.lyrics));
  }
}
