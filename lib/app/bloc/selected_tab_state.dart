part of 'selected_tab_bloc.dart';

enum SelectedTab { lyrics, playlists }

class SelectedTabState extends Equatable {
  const SelectedTabState({
    this.selectedTab = SelectedTab.lyrics,
  });

  final SelectedTab selectedTab;

  SelectedTabState copyWith({
    SelectedTab? selectedTab,
  }) {
    return SelectedTabState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => <Object?>[selectedTab];
}
