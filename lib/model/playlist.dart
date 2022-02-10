import 'package:json_annotation/json_annotation.dart';

part 'playlist.g.dart';

@JsonSerializable()
class Playlist {
  const Playlist({
    required this.id,
    required this.title,
    required this.members,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);

  final String id;
  final String title;
  final List<String> members;

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);

  @override
  String toString() {
    return 'Playlist: $title';
  }
}

@JsonSerializable()
class PlaylistPost {
  const PlaylistPost({
    required this.title,
    required this.members,
  });

  factory PlaylistPost.fromJson(Map<String, dynamic> json) =>
      _$PlaylistPostFromJson(json);

  final String title;
  final List<String> members;

  Map<String, dynamic> toJson() => _$PlaylistPostToJson(this);
}
