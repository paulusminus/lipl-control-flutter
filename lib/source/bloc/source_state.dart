part of 'source_bloc.dart';

enum SourceStatus {
  initial,
  loading,
  success,
  failure,
}

enum SelectedTab { lyrics, playlists }

class SourceState extends Equatable {
  const SourceState({
    this.status = SourceStatus.initial,
    this.lyrics = const <Lyric>[],
    this.playlists = const <Playlist>[],
    this.selectedPlaylist,
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
  final Playlist? selectedPlaylist;
  final SelectedTab selectedTab;

  SourceState copyWith({
    SourceStatus Function()? status,
    List<Lyric> Function()? lyrics,
    List<Playlist> Function()? playlists,
    Playlist? Function()? selectedPlaylist,
    SelectedTab Function()? selectedTab,
  }) {
    return SourceState(
      status: status == null ? this.status : status(),
      lyrics: lyrics == null ? this.lyrics : lyrics(),
      playlists: playlists == null ? this.playlists : playlists(),
      selectedPlaylist:
          selectedPlaylist == null ? this.selectedPlaylist : selectedPlaylist(),
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

  List<Lyric> selectedLyrics() => selectedPlaylist == null
      ? lyrics
      : selectedPlaylist!.members
          .map(
            (String lyricId) => lyrics.firstWhere(
              (Lyric lyric) => lyric.id == lyricId,
              orElse: null,
            ),
          )
          .where((Lyric? lyric) => lyric != null)
          .toList();

  @override
  List<Object?> get props =>
      <Object?>[status, lyrics, playlists, selectedPlaylist, selectedTab];
}
