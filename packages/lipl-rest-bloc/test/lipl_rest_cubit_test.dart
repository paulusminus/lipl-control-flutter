import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';
import 'package:test/test.dart';

import 'lipl_rest_api_in_memory.dart';

const lyricPost1 = LyricPost(
  title: 'aan de amsterdamse grachten',
  parts: [],
);

const lyricPost2 = LyricPost(
  title: 'Breng eens een zonnetje',
  parts: [],
);

const lyricPost3 = LyricPost(
  title: 'Oh kindeke klein',
  parts: [],
);

const addingLyric = LyricPost(
  title: 'Adding lyric',
  parts: [],
);

const addingPlaylist = PlaylistPost(
  title: 'Allemaal helemaal te gek',
  members: [],
);

PlaylistPost initialPlaylistPost(String title, List<String> members) =>
    PlaylistPost(
      title: 'Alles',
      members: members,
    );

bool isSuccess(RestState state) => state.status == RestStatus.success;

void main() {
  late List<Lyric> initialLyrics;
  late List<Playlist> initialPlaylists;
  late LiplRestApiInterface api;
  late LiplRestApiInterface errorApi;

  setUp(() async {
    api = InMemoryRestApi();
    initialLyrics = [
      await api.postLyric(lyricPost1),
      await api.postLyric(lyricPost2),
      await api.postLyric(lyricPost3),
    ];
    initialPlaylists = [
      await api.postPlaylist(
        initialPlaylistPost(
          'Alles',
          initialLyrics
              .map(
                (e) => e.id,
              )
              .toList(),
        ),
      )
    ];
  });

  group('LiplRestCubit', () {
    late String addedLyricId;
    late String addedPlaylistId;

    RestState loaded(LiplRestApiInterface api) => RestState(
          lyrics: initialLyrics.sortByTitle(),
          playlists: initialPlaylists.sortByTitle(),
          status: RestStatus.success,
          api: api,
        );

    DioError error(String path) =>
        DioError(requestOptions: RequestOptions(path: path));

    DioError unauthorized(String path) => DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
            requestOptions: RequestOptions(path: path),
            statusCode: 401,
          ),
        );

    group('Lyric', () {
      test('Constructor', () {
        final cubit = LiplRestCubit();
        expect(
          cubit.state.copyWith(api: api),
          RestState.initial().copyWith(api: api),
        );
      });

      blocTest<LiplRestCubit, RestState>(
        'load',
        build: () => LiplRestCubit(),
        act: (cubit) async => await cubit.load(api),
        expect: () => [
          RestState(
            lyrics: const [],
            playlists: const [],
            status: RestStatus.loading,
            api: api,
          ),
          loaded(api),
        ],
      );

      blocTest<LiplRestCubit, RestState>(
        'load plus add',
        build: () => LiplRestCubit(),
        seed: () => loaded(api),
        act: (cubit) async {
          await cubit.postLyric(addingLyric);
          final lyric = (await api.getLyrics())
              .firstWhere((element) => element.title == addingLyric.title);
          addedLyricId = lyric.id;
        },
        expect: () => [
          loaded(api).copyWith(status: RestStatus.changing),
          RestState(
            lyrics: [
              ...initialLyrics,
              Lyric(
                id: addedLyricId,
                title: addingLyric.title,
                parts: addingLyric.parts,
              )
            ].sortByTitle(),
            playlists: initialPlaylists.sortByTitle(),
            status: RestStatus.success,
            api: api,
          ),
        ],
      );

      blocTest<LiplRestCubit, RestState>(
        'load plus delete',
        build: () => LiplRestCubit(),
        seed: () => loaded(api),
        act: (cubit) => cubit.deleteLyric(initialLyrics.first.id),
        expect: () => [
          loaded(api).copyWith(status: RestStatus.changing),
          RestState(
            lyrics: initialLyrics
                .sortByTitle()
                .where(
                  (lyric) => lyric.id != initialLyrics.first.id,
                )
                .toList(),
            playlists: initialPlaylists
                .map((p) => Playlist(
                    id: p.id,
                    title: p.title,
                    members: p.members
                        .where(
                          (element) => element != initialLyrics.first.id,
                        )
                        .toList()))
                .toList(),
            status: RestStatus.success,
            api: api,
          ),
        ],
      );

      blocTest<LiplRestCubit, RestState>(
        'load plus change',
        build: () => LiplRestCubit(),
        seed: () => loaded(api),
        act: (cubit) async => await cubit.putLyric(
          initialLyrics[1].copyWith(
            title: () => 'Breng eens een emmer',
          ),
        ),
        expect: () => [
          loaded(api).copyWith(status: RestStatus.changing),
          RestState(
            lyrics: [
              initialLyrics[0],
              initialLyrics[1].copyWith(title: () => 'Breng eens een emmer'),
              initialLyrics[2],
            ].sortByTitle(),
            playlists: initialPlaylists.sortByTitle(),
            status: RestStatus.success,
            api: api,
          )
        ],
      );
    }); // end group Lyric

    group('Lyric exceptions', () {
      blocTest<LiplRestCubit, RestState>(
        'load',
        setUp: () {
          errorApi = ExceptionsRestApi(error('lyric'));
        },
        build: () => LiplRestCubit(),
        act: (cubit) async => await cubit.load(errorApi),
        expect: () => [
          RestState.initial().copyWith(
            status: RestStatus.loading,
            api: errorApi,
          ),
        ],
        errors: () => [isA<DioError>()],
      );

      blocTest<LiplRestCubit, RestState>(
        'load unauthorized',
        setUp: () {
          errorApi = ExceptionsRestApi(unauthorized('lyric'));
        },
        build: () => LiplRestCubit(),
        act: (cubit) async => await cubit.load(errorApi),
        expect: () => [
          RestState.initial().copyWith(
            status: RestStatus.loading,
            api: errorApi,
          ),
          RestState.initial().copyWith(
            status: RestStatus.unauthorized,
            api: errorApi,
          )
        ],
        errors: () => [isA<DioError>()],
      );

      blocTest<LiplRestCubit, RestState>(
        'load plus add',
        setUp: () {
          errorApi = ExceptionsRestApi(error('lyric/5'));
        },
        build: () => LiplRestCubit(),
        seed: () => loaded(errorApi),
        act: (cubit) async => await cubit.postLyric(const LyricPost(
          title: 'Whatever',
          parts: [],
        )),
        wait: const Duration(milliseconds: 10),
        expect: () => [
          loaded(errorApi).copyWith(
            status: RestStatus.changing,
          )
        ],
        errors: () => [isA<DioError>()],
      );

      blocTest<LiplRestCubit, RestState>(
        'load plus delete',
        setUp: () {
          errorApi = ExceptionsRestApi(error('lyric/5'));
        },
        build: () => LiplRestCubit(),
        seed: () => loaded(errorApi),
        act: (cubit) async => await cubit.deleteLyric('5'),
        expect: () => [
          loaded(errorApi).copyWith(status: RestStatus.changing),
        ],
        errors: () => [isA<DioError>()],
      );

      blocTest<LiplRestCubit, RestState>(
        'load plus change',
        setUp: () {
          errorApi = ExceptionsRestApi(error('lyric/5'));
        },
        build: () => LiplRestCubit(),
        seed: () => loaded(errorApi),
        act: (cubit) async => await cubit.putLyric(
          initialLyrics[1].copyWith(
            title: () => 'Breng eens een emmer',
          ),
        ),
        expect: () => [
          loaded(errorApi).copyWith(status: RestStatus.changing),
        ],
        errors: () => [isA<DioError>()],
      );
    }); // end group Lyric Exceptions

    group('Playlist', () {
      blocTest<LiplRestCubit, RestState>(
        'load plus add',
        build: () => LiplRestCubit(),
        seed: () => loaded(api),
        act: (cubit) async {
          await cubit.postPlaylist(addingPlaylist);
          final playlist = (await api.getPlaylists())
              .firstWhere((element) => element.title == addingPlaylist.title);
          addedPlaylistId = playlist.id;
        },
        expect: () => [
          loaded(api).copyWith(status: RestStatus.changing),
          loaded(api).copyWith(
            playlists: [
              ...initialPlaylists,
              Playlist(
                id: addedPlaylistId,
                title: addingPlaylist.title,
                members: addingPlaylist.members,
              )
            ].sortByTitle(),
          )
        ],
      );

      blocTest<LiplRestCubit, RestState>(
        'load plus delete',
        build: () => LiplRestCubit(),
        seed: () => loaded(api),
        act: (cubit) async =>
            await cubit.deletePlaylist(initialPlaylists.first.id),
        expect: () => [
          loaded(api).copyWith(status: RestStatus.changing),
          loaded(api).copyWith(
              playlists: initialPlaylists
                  .sortByTitle()
                  .where((playlist) => playlist.id != initialPlaylists.first.id)
                  .toList())
        ],
      );

      blocTest<LiplRestCubit, RestState>(
        'load plus change',
        build: () => LiplRestCubit(),
        seed: () => loaded(api),
        act: (cubit) async => await cubit.putPlaylist(
          initialPlaylists[0].copyWith(
            title: () => 'Breng eens wat meer',
          ),
        ),
        expect: () => [
          loaded(api).copyWith(status: RestStatus.changing),
          loaded(api).copyWith(
            playlists: [
              initialPlaylists[0].copyWith(
                title: () => 'Breng eens wat meer',
              ),
            ].sortByTitle(),
          )
        ],
      );
    }); // end group Playlist

    group('Playlist Exceptions', () {
      blocTest<LiplRestCubit, RestState>(
        'load plus add',
        setUp: () {
          errorApi = ExceptionsRestApi(error('playlist'));
        },
        build: () => LiplRestCubit(),
        seed: () => loaded(errorApi),
        act: (cubit) async => await cubit.postPlaylist(addingPlaylist),
        expect: () => [
          loaded(errorApi).copyWith(status: RestStatus.changing),
        ],
        errors: () => [isA<DioError>()],
      );

      blocTest<LiplRestCubit, RestState>(
        'load plus delete',
        setUp: () {
          errorApi = ExceptionsRestApi(error('playlist/4'));
        },
        build: () => LiplRestCubit(),
        seed: () => loaded(errorApi),
        act: (cubit) async =>
            await cubit.deletePlaylist(initialPlaylists[0].id),
        expect: () => [
          loaded(errorApi).copyWith(status: RestStatus.changing),
        ],
        errors: () => [isA<DioError>()],
      );

      blocTest<LiplRestCubit, RestState>(
        'load plus change',
        setUp: () {
          errorApi = ExceptionsRestApi(error('playlist/4'));
        },
        build: () => LiplRestCubit(),
        seed: () => loaded(errorApi),
        act: (cubit) async => await cubit.putPlaylist(
          initialPlaylists[0].copyWith(
            title: () => 'Breng eens wat meer',
          ),
        ),
        expect: () => [
          loaded(errorApi).copyWith(status: RestStatus.changing),
        ],
        errors: () => [isA<DioError>()],
      );
    }); // end group Playlist Exceptions
  }); // end group LiplRestBloc
}
