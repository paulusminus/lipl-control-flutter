import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

import 'package:bs58/bs58.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:lipl_test/dal/dal.dart';
import 'package:lipl_test/model/model.dart';
import 'package:uuid/uuid.dart'; // ignore: import_of_legacy_library_into_null_safe

List<T> toList<T>(String json, T Function(Map<String, dynamic>) f) =>
    (jsonDecode(json) as List<Map<String, dynamic>>).map(f).toList();

String newId(Uuid uuid) {
  final List<int> elements = <int>[
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  final Uint8List buffer = Uint8List.fromList(elements);
  uuid.v4buffer(buffer);
  return base58.encode(buffer);
}

class FakeDal implements Dal {
  final Uuid uuid = const Uuid();
  List<Lyric> lyrics = fakeLyrics();
  List<Playlist> playlists = fakePlaylists();

  @override
  Future<List<Summary>> getLyricSummaries() => Future<List<Summary>>.value(
      lyrics.map((Lyric l) => Summary(id: l.id, title: l.title)).toList());

  @override
  Future<List<Lyric>> getLyrics() => Future<List<Lyric>>.value(lyrics);

  @override
  Future<void> deleteLyric(String id) {
    lyrics = lyrics.where((Lyric element) => element.id != id).toList();
    return Future<void>.value();
  }

  @override
  Future<Lyric> postLyric(LyricPost post) {
    final Lyric lyric =
        Lyric(id: newId(uuid), title: post.title, parts: post.parts);
    lyrics.add(lyric);
    return Future<Lyric>.value(lyric);
  }

  @override
  Future<Lyric> putLyric(String id, LyricPost post) {
    final Lyric lyric = Lyric(id: id, title: post.title, parts: post.parts);
    lyrics = lyrics.where((Lyric element) => element.id != id).toList();
    lyrics.add(lyric);
    return Future<Lyric>.value(lyric);
  }

  @override
  Future<List<Summary>> getPlaylistSummaries() =>
      Future<List<Summary>>.value(playlists
          .map((Playlist p) => Summary(id: p.id, title: p.title))
          .toList());

  @override
  Future<List<Playlist>> getPlaylists() =>
      Future<List<Playlist>>.value(playlists);

  @override
  Future<void> deletePlaylist(String id) {
    playlists =
        playlists.where((Playlist element) => element.id != id).toList();
    return Future<void>.value();
  }

  @override
  Future<Playlist> postPlaylist(PlaylistPost post) {
    final Playlist playlist =
        Playlist(id: newId(uuid), title: post.title, members: post.members);
    playlists.add(playlist);
    return Future<Playlist>.value(playlist);
  }

  @override
  Future<Playlist> putPlaylist(String id, PlaylistPost post) {
    final Playlist playlist =
        Playlist(id: id, title: post.title, members: post.members);
    playlists =
        playlists.where((Playlist element) => element.id != id).toList();
    playlists.add(playlist);
    return Future<Playlist>.value(playlist);
  }
}
