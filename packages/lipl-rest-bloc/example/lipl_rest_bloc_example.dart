import 'dart:async';
import 'dart:io';

import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';
import 'package:logging/logging.dart';

final Logger log = Logger('lipl_repo_stream_example');

const Credentials credentials = Credentials(
  username: 'paul',
  password: 'CumGranoSalis',
);
const String baseUrl = 'https://www.paulmin.nl/api/v1/';

String selectTitle(Summary summary) => summary.title;

String joinTitles(List<Summary> summaries) =>
    summaries.map(selectTitle).join(', ');

bool isSuccess(LiplRestState state) => state.status == LiplRestStatus.success;

void Function(List<Summary>) printTitles(String itemType) => (summaries) {
      log.info('$itemType: ${summaries.length} titles');
    };

List<Lyric> selectLyrics(LiplRestState state) => state.lyrics;
List<Playlist> selectPlaylists(LiplRestState state) => state.playlists;

Future<void> main() async {
  Logger.root.level = Level.ALL;
  log.onRecord.listen((record) {
    stdout.writeln('${record.level.name}: ${record.time}: ${record.message}');
  });
  final LiplRestBloc bloc = LiplRestBloc();

  final StreamSubscription<List<Lyric>> subscription1 = bloc.stream
      .where(isSuccess)
      .map(selectLyrics)
      .distinct()
      .listen(printTitles('Lyric'));
  final StreamSubscription<List<Playlist>> subscription2 = bloc.stream
      .where(isSuccess)
      .map(selectPlaylists)
      .distinct()
      .listen(printTitles('Playlist'));

  log.info('Loading');
  bloc.add(
    LiplRestEventLoad(
      api: apiFromConfig(
        credentials: credentials,
        baseUrl: baseUrl,
      ),
    ),
  );
  await bloc.stream.firstWhere(isSuccess);
  log.info('Loaded');

  log.info('Adding Allegaartje');
  const PlaylistPost playlistPost = PlaylistPost(
    title: 'Allegaartje',
    members: [
      'EqCnuUKcSkoWPyvaRK8Jbh',
      'LEt7kAx8sAjPmrAKuwkH8S',
      'HvBRBoaHh4rNsWVJgZNRvY',
    ],
  );
  bloc.add(LiplRestEventPostPlaylist(playlistPost: playlistPost));
  await bloc.stream.firstWhere(isSuccess);
  log.info('Added Allegaartje');

  final Playlist p = bloc.state.playlists
      .firstWhere((Playlist playlist) => playlist.title == 'Allegaartje');

  log.info('Renaming Allegaartje');
  bloc.add(
    LiplRestEventPutPlaylist(
      playlist: p.copyWith(title: () => 'Allemaal te gek'),
    ),
  );
  await bloc.stream.firstWhere(isSuccess);
  log.info('Renamed Allegaartje to Allemaal te gek');

  log.info('Deleting playlist');
  bloc.add(LiplRestEventDeletePlaylist(id: p.id));
  await bloc.stream.firstWhere(isSuccess);
  log.info('Deleted playlist');

  const lyricPost = LyricPost(
    title: 'Leningrad 19',
    parts: [
      [
        'Victor was born',
        'in spring of 44',
        'and never saw',
        'his father anymore',
        'the greatest sacrifice'
      ],
      [
        'I was born in 49',
        'a cold war kid in McCarthy time',
        'stop them at the 38 parallel',
        'blast those to hell'
      ],
    ],
  );

  log.info('Adding Lyric Leningrad');
  bloc.add(LiplRestEventPostLyric(lyricPost: lyricPost));
  await bloc.stream.firstWhere(isSuccess);
  log.info('Added Leningrad');

  final l = bloc.state.lyrics
      .firstWhere((Lyric lyric) => lyric.title == 'Leningrad 19');

  log.info('Renaming Leningrad 19');
  bloc.add(
    LiplRestEventPutLyric(
      lyric: l.copyWith(title: () => 'Leningrad 44'),
    ),
  );
  await bloc.stream.firstWhere(isSuccess);
  log.info('Renamed Leningrad 19 to Leningrad 44');

  log.info('Deleting lyric');
  bloc.add(
    LiplRestEventDeleteLyric(id: l.id),
  );
  await bloc.stream.firstWhere(isSuccess);
  log.info('Deleted lyric');

  await subscription1.cancel();
  await subscription2.cancel();
  await bloc.close();

  log.info('Finished');
}
