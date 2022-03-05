part of 'edit_playlist_bloc.dart';

enum EditPlaylistStatus { initial, loading, succes, failure }

extension EditPlaylistStatusX on EditPlaylistStatus {
  bool get isLoadingOrSuccess => <EditPlaylistStatus>[
        EditPlaylistStatus.loading,
        EditPlaylistStatus.succes,
      ].contains(this);
}

class EditPlaylistState extends Equatable {
  const EditPlaylistState({
    this.status = EditPlaylistStatus.initial,
    this.id,
    this.title = '',
    this.search = '',
    this.members = const <Lyric>[],
    this.lyrics = const <Lyric>[],
  });

  final EditPlaylistStatus status;
  final String? id;
  final String title;
  final String search;
  final List<Lyric> members;
  final List<Lyric> lyrics;

  bool get isNewLyric => id == null;

  List<Lyric> get filtered => lyrics
      .where(
        (Lyric lyric) =>
            lyric.title.toLowerCase().contains(search.toLowerCase()),
      )
      .toList();

  EditPlaylistState copyWith({
    EditPlaylistStatus? status,
    String? id,
    String? title,
    String? search,
    List<Lyric>? members,
  }) =>
      EditPlaylistState(
        status: status ?? this.status,
        id: id ?? this.id,
        title: title ?? this.title,
        search: search ?? this.search,
        members: members ?? this.members,
        lyrics: lyrics,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        id,
        title,
        search,
        members,
        lyrics,
      ];
}
