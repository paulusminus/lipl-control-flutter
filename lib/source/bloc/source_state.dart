part of 'source_bloc.dart';

enum SourceStatus {
  initial,
  loading,
  success,
  failure,
}

class Expandable<T> extends Equatable {
  const Expandable({required this.data, this.expanded = false});
  final T data;
  final bool expanded;

  Expandable<T> copyWith(T? t, bool? expanded) => Expandable<T>(
        data: t ?? data,
        expanded: expanded ?? this.expanded,
      );

  Expandable<T> toggled() => Expandable<T>(data: data, expanded: !expanded);

  @override
  List<Object?> get props => <Object?>[data, expanded];
}

class SourceState extends Equatable {
  const SourceState({
    this.status = SourceStatus.initial,
    this.lyrics = const <Expandable<Lyric>>[],
    this.playlists = const <Playlist>[],
    this.selectedPlaylist,
  });

  factory SourceState.loading() => const SourceState().copyWith(
        status: () => SourceStatus.loading,
      );

  factory SourceState.failure() => const SourceState().copyWith(
        status: () => SourceStatus.failure,
      );

  final SourceStatus status;
  final List<Expandable<Lyric>> lyrics;
  final List<Playlist> playlists;
  final Playlist? selectedPlaylist;

  SourceState copyWith({
    SourceStatus Function()? status,
    List<Expandable<Lyric>> Function()? lyrics,
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
          (Expandable<Lyric> lyric) => playlist.members.contains(lyric.data.id),
        )
        .map((Expandable<Lyric> lyric) => lyric.data.title)
        .toList();
  }

  List<Expandable<Lyric>> selectedLyrics() => selectedPlaylist == null
      ? lyrics
      : selectedPlaylist!.members
          .map(
            (String lyricId) => lyrics.firstWhere(
              (Expandable<Lyric> lyric) => lyric.data.id == lyricId,
              orElse: null,
            ),
          )
          .where((Expandable<Lyric>? lyric) => lyric != null)
          .toList();

  @override
  List<Object?> get props =>
      <Object?>[status, lyrics, playlists, selectedPlaylist];
}
