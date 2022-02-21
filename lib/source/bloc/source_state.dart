part of 'source_bloc.dart';

enum SourceStatus {
  initial,
  loading,
  success,
  failure,
  noCredentials,
}

enum SelectedTab { lyrics, playlists }

class SourceState extends Equatable {
  const SourceState({
    this.status = SourceStatus.initial,
    this.lyrics = const <Lyric>[],
    this.playlists = const <Playlist>[],
    this.selectedTab = SelectedTab.lyrics,
  });

  factory SourceState.loading() => const SourceState().copyWith(
        status: () => SourceStatus.loading,
      );

  factory SourceState.failure() => const SourceState().copyWith(
        status: () => SourceStatus.failure,
      );

  final SourceStatus status;
  final List<Lyric> lyrics;
  final List<Playlist> playlists;
  final SelectedTab selectedTab;

  SourceState copyWith({
    SourceStatus Function()? status,
    List<Lyric> Function()? lyrics,
    List<Playlist> Function()? playlists,
    SelectedTab Function()? selectedTab,
  }) {
    return SourceState(
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
