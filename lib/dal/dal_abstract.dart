import 'dart:core';

import 'package:lipl_test/model/model.dart';

abstract class DalException implements Exception {}

abstract class Dal {
  Future<List<Summary>> getLyricSummaries();
  Future<List<Lyric>> getLyrics();
  Future<void> deleteLyric(String id);
  Future<Lyric> postLyric(LyricPost post);
  Future<Lyric> putLyric(String id, LyricPost post);

  Future<List<Summary>> getPlaylistSummaries();
  Future<List<Playlist>> getPlaylists();
  Future<void> deletePlaylist(String id);
  Future<Playlist> postPlaylist(PlaylistPost post);
  Future<Playlist> putPlaylist(String id, PlaylistPost post);
}
