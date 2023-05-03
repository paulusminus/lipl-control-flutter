import 'dart:io';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:parts/parts.dart';

const String path = '/home/paul/Documenten/lipl.data/Geheugenkoor/';
const Credentials? credentials = null;
const String baseUrl = 'http://localhost:5035/api/v1/';

bool isSuccess(LiplRestState state) => state.status == LiplRestStatus.success;

Future<LyricPost> fromFile(File file) async {
  final String title = p.basenameWithoutExtension(file.path);
  final text = await file.readAsString();
  return LyricPost(
    title: title,
    parts: toParts(text),
  );
}

Future<void> main() async {
  final LiplRestBloc bloc = LiplRestBloc();
  bloc.add(
    LiplRestEventLoad(
      api: apiFromConfig(
        baseUrl: baseUrl,
      ),
    ),
  );
  await bloc.stream.firstWhere(isSuccess);

  Future<Lyric> postLyric(File file) async {
    final lyricPost = await fromFile(file);
    bloc.add(
      LiplRestEventPostLyric(lyricPost: lyricPost),
    );
    await bloc.stream.firstWhere(isSuccess);
    final Lyric lyric = bloc.state.lyrics.firstWhere(
      (Lyric lyric) => lyric.title == lyricPost.title,
    );
    return lyric;
  }

  final List<Lyric> lyrics = await Directory(path)
      .list()
      .where(
        (FileSystemEntity entity) => entity is File,
      )
      .map(
        (FileSystemEntity entity) => entity as File,
      )
      .where(
        (File file) => p.extension(file.path).toLowerCase() == '.txt',
      )
      .asyncMap(postLyric)
      .toList();

  final PlaylistPost playlistPost = PlaylistPost(
    title: 'Alles',
    members: lyrics.map((Lyric lyric) => lyric.id).toList(),
  );
  bloc.add(LiplRestEventPostPlaylist(playlistPost: playlistPost));
  await bloc.stream.firstWhere(isSuccess);

  await bloc.close();
}
