// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      id: json['id'] as String,
      title: json['title'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'members': instance.members,
    };

PlaylistPost _$PlaylistPostFromJson(Map<String, dynamic> json) => PlaylistPost(
      title: json['title'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PlaylistPostToJson(PlaylistPost instance) =>
    <String, dynamic>{
      'title': instance.title,
      'members': instance.members,
    };
