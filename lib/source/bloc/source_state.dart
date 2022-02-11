part of 'source_bloc.dart';

enum SourceStatus {
  initial,
  loading,
  success,
  failure,
}

class SourceState extends Equatable {
  const SourceState({
    this.status = SourceStatus.initial,
    this.lyrics = const <Lyric>[],
    this.playlists = const <Playlist>[],
    this.selectedPlaylist,
  });

  factory SourceState.initial() => const SourceState(
        lyrics: <Lyric>[],
        playlists: <Playlist>[],
        status: SourceStatus.initial,
        selectedPlaylist: null,
      );

  factory SourceState.loading() => SourceState.initial().copyWith(
        status: () => SourceStatus.loading,
      );

  factory SourceState.failure() => SourceState.initial().copyWith(
        status: () => SourceStatus.failure,
      );

  final SourceStatus status;
  final List<Lyric> lyrics;
  final List<Playlist> playlists;
  final Playlist? selectedPlaylist;

  SourceState copyWith({
    SourceStatus Function()? status,
    List<Lyric> Function()? lyrics,
    List<Playlist> Function()? playlists,
    Playlist? Function()? selectedPlaylist,
  }) {
    return SourceState(
      status: status == null ? this.status : status(),
      lyrics: lyrics == null ? this.lyrics : lyrics(),
      playlists: playlists == null ? this.playlists : playlists(),
      selectedPlaylist:
          selectedPlaylist == null ? this.selectedPlaylist : selectedPlaylist(),
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
          .map((String lyricId) =>
              lyrics.firstWhere((Lyric lyric) => lyric.id == lyricId))
          .toList();

  @override
  List<Object?> get props =>
      <Object?>[status, lyrics, playlists, selectedPlaylist];
}
