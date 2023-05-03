import 'package:lipl_rest_bloc/src/basic_authentication.dart';

import 'lipl_rest_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'lipl_rest_api.g.dart';

abstract class LiplRestApiInterface {
  Future<List<Lyric>> getLyrics();
  Future<List<Summary>> getLyricSummaries();
  Future<Lyric> postLyric(@Body() LyricPost post);
  Future<void> deleteLyric(@Path() String id);
  Future<Lyric> putLyric(@Path() String id, @Body() Lyric lyric);
  Future<List<Playlist>> getPlaylists();
  Future<List<Summary>> getPlaylistSummaries();
  Future<Playlist> postPlaylist(@Body() PlaylistPost post);
  Future<void> deletePlaylist(@Path() String id);
  Future<Playlist> putPlaylist(@Path() String id, @Body() Playlist playlist);
}

LiplRestApi apiFromConfig({Credentials? credentials, String? baseUrl}) {
  final Dio dio = credentials == null
      ? Dio()
      : basicAuthenticationDio(
          credentials: credentials,
        );

  return baseUrl == null
      ? LiplRestApi(dio)
      : LiplRestApi(dio, baseUrl: baseUrl);
}

@RestApi(baseUrl: 'https://lipl.paulmin.nl/api/v1/')
abstract class LiplRestApi implements LiplRestApiInterface {
  factory LiplRestApi(Dio dio, {String baseUrl}) = _LiplRestApi;

  @override
  @GET('lyric?full=true')
  Future<List<Lyric>> getLyrics();

  @override
  @GET('lyric')
  Future<List<Summary>> getLyricSummaries();

  @override
  @POST('lyric')
  Future<Lyric> postLyric(@Body() LyricPost post);

  @override
  @DELETE('lyric/{id}')
  Future<void> deleteLyric(@Path() String id);

  @override
  @PUT('lyric/{id}')
  Future<Lyric> putLyric(@Path() String id, @Body() Lyric lyric);

  @override
  @GET('playlist?full=true')
  Future<List<Playlist>> getPlaylists();

  @override
  @GET('playlist')
  Future<List<Summary>> getPlaylistSummaries();

  @override
  @POST('playlist')
  Future<Playlist> postPlaylist(@Body() PlaylistPost post);

  @override
  @DELETE('playlist/{id}')
  Future<void> deletePlaylist(@Path() String id);

  @override
  @PUT('playlist/{id}')
  Future<Playlist> putPlaylist(@Path() String id, @Body() Playlist playlist);
}
