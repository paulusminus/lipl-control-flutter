import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_bloc/source/bloc/source_bloc.dart';
import 'package:lipl_repo/lipl_repo.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc(SourceBloc source)
      : super(const ListState(lyrics: <Expandable<Lyric>>[])) {
    source.stream
        .where((SourceState state) => state.status == SourceStatus.success)
        .listen((SourceState state) {
      add(ListSourceChanged(lyrics: state.selectedLyrics()));
    });
    on<ListSourceChanged>(_onListSelectedLyricsChanged);
    on<ListItemToggleExpanded>(_onListItemToggleExpanded);
  }

  void _onListSelectedLyricsChanged(
    ListSourceChanged event,
    Emitter<ListState> emit,
  ) {
    emit(ListState(lyrics: event.lyrics));
  }

  void _onListItemToggleExpanded(
    ListItemToggleExpanded event,
    Emitter<ListState> emit,
  ) {
    final List<Expandable<Lyric>> expandableLyrics = state.lyrics
        .map(
          (Expandable<Lyric> expandable) => expandable.data.id == event.id
              ? expandable.toggled()
              : expandable,
        )
        .toList();
    emit(ListState(lyrics: expandableLyrics));
  }
}
