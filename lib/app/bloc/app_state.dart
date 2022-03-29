part of 'app_bloc.dart';

enum AppStatus {
  initial,
  loading,
  success,
  failure,
  noCredentials,
}

enum SelectedTab { lyrics, playlists }

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.initial,
    this.lyrics = const <Lyric>[],
    this.playlists = const <Playlist>[],
    this.selectedTab = SelectedTab.lyrics,
  });

  factory AppState.loading() => const AppState().copyWith(
        status: () => AppStatus.loading,
      );

  factory AppState.failure() => const AppState().copyWith(
        status: () => AppStatus.failure,
      );

  final AppStatus status;
  final List<Lyric> lyrics;
  final List<Playlist> playlists;
  final SelectedTab selectedTab;

  AppState copyWith({
    AppStatus Function()? status,
    List<Lyric> Function()? lyrics,
    List<Playlist> Function()? playlists,
    SelectedTab Function()? selectedTab,
  }) {
    return AppState(
      status: status == null ? this.status : status(),
      lyrics: lyrics == null ? this.lyrics : lyrics(),
      playlists: playlists == null ? this.playlists : playlists(),
      selectedTab: selectedTab == null ? this.selectedTab : selectedTab(),
    );
  }

  List<String> lyricTitles(Playlist playlist) {
    return lyrics
        .where(
          (Lyric lyric) => playlist.members.contains(lyric.id),
        )
        .map((Lyric lyric) => lyric.title)
        .toList();
  }

  @override
  List<Object?> get props => <Object?>[status, lyrics, playlists, selectedTab];
}
