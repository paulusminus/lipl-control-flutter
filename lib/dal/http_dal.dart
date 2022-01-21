import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:lipl_test/dal/dal.dart';
import 'package:lipl_test/model/model.dart';

const String GET = 'GET';
const String PUT = 'PUT';
const String POST = 'POST';
const String DELETE = 'DELETE';

class ApiException implements DalException {
  const ApiException(
      {required this.url, required this.statusCode, required this.method});

  final String url;
  final int statusCode;
  final String method;

  @override
  String toString() {
    return 'Failed to $method $url with statuscode $statusCode';
  }
}

class LiplClient extends BaseClient {
  LiplClient({
    required this.username,
    required this.password,
  });

  final Client client = Client();
  final String username;
  final String password;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['accept'] = 'application/json; charset=utf-8';
    request.headers['accept-encoding'] = 'gzip';
    request.headers['authorization'] =
        basicAuthenticationHeader(username, password);

    return client.send(request);
  }
}

class HttpDal implements Dal {
  const HttpDal({
    required this.client,
    required this.prefix,
  });

  final LiplClient client;
  final String prefix;

  @override
  Future<List<Summary>> getLyricSummaries() async {
    final Uri uri = Uri.parse('${prefix}lyric');
    final Response response = await client.get(uri);
    final List<dynamic> json = jsonDecode(response.body) as List<dynamic>;
    return json.map((dynamic e) => Summary.fromJson(e)).toList();
  }

  @override
  Future<List<Lyric>> getLyrics() async {
    final Uri uri = Uri.parse('${prefix}lyric?full=true');
    final Response response = await client.get(uri);
    final List<Map<String, dynamic>> json =
        jsonDecode(response.body) as List<Map<String, dynamic>>;
    return json.map((Map<String, dynamic> e) => Lyric.fromJson(e)).toList();
  }

  @override
  Future<void> deleteLyric(String id) async {
    final Uri uri = Uri.parse('${prefix}lyric/$id');
    await client.delete(uri);
  }

  @override
  Future<Lyric> postLyric(LyricPost post) async {
    final Uri uri = Uri.parse('${prefix}lyric');
    final Response response = await client.post(uri, body: post.toJson());
    final Map<String, dynamic> json = jsonDecode(response.body);
    return Lyric.fromJson(json);
  }

  @override
  Future<Lyric> putLyric(String id, LyricPost post) async {
    final Uri uri = Uri.parse('${prefix}lyric/$id');
    final Response response = await client.put(uri, body: post.toJson());
    final Map<String, dynamic> json = jsonDecode(response.body);
    return Lyric.fromJson(json);
  }

  @override
  Future<List<Summary>> getPlaylistSummaries() async {
    final Uri uri = Uri.parse('${prefix}playlist');
    final Response response = await client.get(uri);
    final List<dynamic> json = jsonDecode(response.body) as List<dynamic>;
    return json.map((dynamic e) => Summary.fromJson(e)).toList();
  }

  @override
  Future<List<Playlist>> getPlaylists() async {
    final Uri uri = Uri.parse('${prefix}playlist?full=true');
    final Response response = await client.get(uri);
    final List<Map<String, dynamic>> json =
        jsonDecode(response.body) as List<Map<String, dynamic>>;
    return json.map((Map<String, dynamic> e) => Playlist.fromJson(e)).toList();
  }

  @override
  Future<void> deletePlaylist(String id) async {
    final Uri uri = Uri.parse('${prefix}playlist/$id');
    await client.delete(uri);
  }

  @override
  Future<Playlist> postPlaylist(PlaylistPost post) async {
    final Uri uri = Uri.parse('${prefix}playlist');
    final Response response = await client.post(uri, body: post.toJson());
    final Map<String, dynamic> json = jsonDecode(response.body);
    return Playlist.fromJson(json);
  }

  @override
  Future<Playlist> putPlaylist(String id, PlaylistPost post) async {
    final Uri uri = Uri.parse('${prefix}playlist/$id');
    final Response response = await client.put(uri, body: post.toJson());
    final Map<String, dynamic> json = jsonDecode(response.body);
    return Playlist.fromJson(json);
  }
}

String basicAuthenticationHeader(String username, String password) {
  return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
}
