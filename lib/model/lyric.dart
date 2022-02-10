import 'package:json_annotation/json_annotation.dart';

part 'lyric.g.dart';

@JsonSerializable()
class Lyric {
  const Lyric({
    required this.id,
    required this.title,
    required this.parts,
  });

  factory Lyric.fromJson(Map<String, dynamic> json) => _$LyricFromJson(json);

  final String id;
  final String title;
  final List<List<String>> parts;

  Map<String, dynamic> toJson() => _$LyricToJson(this);

  @override
  String toString() {
    return 'Lyric: $title';
  }
}

@JsonSerializable()
class Summary {
  const Summary({required this.id, required this.title});

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);

  final String id;
  final String title;

  Map<String, dynamic> toJson() => _$SummaryToJson(this);
}

@JsonSerializable()
class LyricPost {
  const LyricPost({
    required this.title,
    required this.parts,
  });

  factory LyricPost.fromJson(Map<String, dynamic> json) =>
      _$LyricPostFromJson(json);

  final String title;
  final List<List<String>> parts;

  Map<String, dynamic> toJson() => _$LyricPostToJson(this);
}
