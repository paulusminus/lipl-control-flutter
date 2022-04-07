import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

enum SelectedTab { lyrics, playlists }

class SelectedTabState extends Equatable {
  const SelectedTabState({
    this.selectedTab = SelectedTab.lyrics,
  });

  final SelectedTab selectedTab;

  @override
  List<Object?> get props => <Object?>[selectedTab];
}

class SelectedTabCubit extends Cubit<SelectedTabState> {
  SelectedTabCubit() : super(const SelectedTabState());

  void selectLyrics() {
    emit(const SelectedTabState(selectedTab: SelectedTab.lyrics));
  }

  void selectPlaylists() {
    emit(const SelectedTabState(selectedTab: SelectedTab.playlists));
  }
}
