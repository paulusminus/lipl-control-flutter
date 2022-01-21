// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lyric _$LyricFromJson(Map<String, dynamic> json) {
  return Lyric(
    id: json['id'] as String,
    title: json['title'] as String,
    parts: (json['parts'] as List<dynamic>)
        .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
        .toList(),
  );
}

Map<String, dynamic> _$LyricToJson(Lyric instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'parts': instance.parts,
    };

Summary _$SummaryFromJson(Map<String, dynamic> json) {
  return Summary(
    id: json['id'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

LyricPost _$LyricPostFromJson(Map<String, dynamic> json) {
  return LyricPost(
    title: json['title'] as String,
    parts: (json['parts'] as List<dynamic>)
        .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
        .toList(),
  );
}

Map<String, dynamic> _$LyricPostToJson(LyricPost instance) => <String, dynamic>{
      'title': instance.title,
      'parts': instance.parts,
    };
