import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockApi extends Mock implements LiplRestApi {}

class LyricPostFake extends Fake implements LyricPost {}

class LyricFake extends Fake implements Lyric {}

class StackTraceFake extends Fake implements StackTrace {}

class PlaylistPostFake extends Fake implements PlaylistPost {}

class PlaylistFake extends Fake implements Playlist {}

const initialLyrics = [
  Lyric(
    id: '2',
    title: 'aan de amsterdamse grachten',
    parts: [],
  ),
  Lyric(
    id: '5',
    title: 'Breng eens een zonnetje',
    parts: [],
  ),
  Lyric(
    id: '45',
    title: 'Oh kindeke klein',
    parts: [],
  ),
];

const initialPlaylists = [
  Playlist(
    id: '2',
    title: 'Alles',
    members: [
      '2',
      '45',
      '5',
    ],
  ),
  Playlist(
    id: '4',
    title: 'Kerst',
    members: [
      '45',
    ],
  ),
];

const addingLyric = LyricPost(
  title: 'Hallo allemaal',
  parts: [],
);
const addingPlaylist = PlaylistPost(
  title: 'Allemaal helemaal te gek',
  members: [],
);

bool isSuccess(LiplRestState state) => state.status == LiplRestStatus.success;

void main() {
  setUpAll(() {
    registerFallbackValue(LyricPostFake());
    registerFallbackValue(LyricFake());
    registerFallbackValue(PlaylistPostFake());
    registerFallbackValue(PlaylistFake());
    registerFallbackValue(StackTraceFake());
  });

  group('LiplRestBloc', () {
    LiplRestState loaded(LiplRestApi api) => LiplRestState(
          lyrics: initialLyrics.sortByTitle(),
          playlists: initialPlaylists.sortByTitle(),
          status: LiplRestStatus.success,
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
      late LiplRestApi api;

      setUp(() {
        api = MockApi();
      });

      test('Constructor', () {
        final bloc = LiplRestBloc();
        expect(
          bloc.state.copyWith(api: api),
          LiplRestState.initial().copyWith(api: api),
        );
      });

      blocTest<LiplRestBloc, LiplRestState>(
        'load',
        setUp: () {
          when(
            () => api.getLyrics(),
          ).thenAnswer(
            (_) async => initialLyrics,
          );

          when(
            () => api.getPlaylists(),
          ).thenAnswer(
            (_) async => initialPlaylists,
          );
        },
        build: () => LiplRestBloc(),
        act: (bloc) => bloc.add(LiplRestEventLoad(api: api)),
        expect: () => [
          LiplRestState(
            lyrics: const [],
            playlists: const [],
            status: LiplRestStatus.loading,
            api: api,
          ),
          loaded(api),
        ],
      );

      blocTest<LiplRestBloc, LiplRestState>(
        'load plus add',
        setUp: () {
          when(
            () => api.postLyric(any<LyricPost>()),
          ).thenAnswer(
            (_) async => Lyric(
              id: '462',
              title: addingLyric.title,
              parts: addingLyric.parts,
            ),
          );
        },
        build: (() => LiplRestBloc()),
        seed: () => loaded(api),
        act: (bloc) => bloc.add(
          LiplRestEventPostLyric(
            lyricPost: addingLyric,
          ),
        ),
        expect: () => [
          loaded(api).copyWith(status: LiplRestStatus.changing),
          LiplRestState(
            lyrics: [
              ...initialLyrics,
              Lyric(
                id: '462',
                title: addingLyric.title,
                parts: addingLyric.parts,
              )
            ].sortByTitle(),
            playlists: initialPlaylists.sortByTitle(),
            status: LiplRestStatus.success,
            api: api,
          ),
        ],
      );

      blocTest<LiplRestBloc, LiplRestState>(
        'load plus delete',
        setUp: () {
          when(
            () => api.deleteLyric(any<String>()),
          ).thenAnswer(
            (_) async {},
          );
        },
        build: () => LiplRestBloc(),
        seed: () => loaded(api),
        act: (bloc) => bloc.add(
          LiplRestEventDeleteLyric(
            id: '5',
          ),
        ),
        // wait: const Duration(milliseconds: 10),
        expect: () => [
          loaded(api).copyWith(status: LiplRestStatus.changing),
          LiplRestState(
            lyrics: initialLyrics
                .sortByTitle()
                .where(
                  (lyric) => lyric.id != '5',
                )
                .toList(),
            playlists: initialPlaylists
                .map((p) => Playlist(
                    id: p.id,
                    title: p.title,
                    members: p.members
                        .where(
                          (element) => element != '5',
                        )
                        .toList()))
                .toList(),
            status: LiplRestStatus.success,
            api: api,
          ),
        ],
      );

      blocTest<LiplRestBloc, LiplRestState>(
        'load plus change',
        setUp: () {
          when(
            () => api.putLyric(
                initialLyrics[1].id,
                initialLyrics[1].copyWith(
                  title: () => 'Breng eens een emmer',
                )),
          ).thenAnswer((invocation) async =>
              initialLyrics[1].copyWith(title: () => 'Breng eens een emmer'));
        },
        build: () => LiplRestBloc(),
        seed: () => loaded(api),
        act: (bloc) => bloc.add(
          LiplRestEventPutLyric(
            lyric: initialLyrics[1].copyWith(
              title: () => 'Breng eens een emmer',
            ),
          ),
        ),
        expect: () => [
          loaded(api).copyWith(status: LiplRestStatus.changing),
          LiplRestState(
            lyrics: [
              initialLyrics[0],
              initialLyrics[1].copyWith(title: () => 'Breng eens een emmer'),
              initialLyrics[2],
            ].sortByTitle(),
            playlists: initialPlaylists.sortByTitle(),
            status: LiplRestStatus.success,
            api: api,
          )
        ],
      );
    }); // end group Lyric

    group('Lyric exceptions', () {
      late LiplRestApi api;

      setUp(() {
        api = MockApi();
      });

      blocTest<LiplRestBloc, LiplRestState>(
        'load',
        setUp: () {
          when(
            () => api.getLyrics(),
          ).thenThrow(error('lyric'));
          when(
            () => api.getPlaylists(),
          ).thenThrow(error('playlist'));
        },
        build: () => LiplRestBloc(),
        act: (bloc) {
          bloc.add(LiplRestEventLoad(api: api));
        },
        expect: () => [
          LiplRestState.initial().copyWith(
            status: LiplRestStatus.loading,
            api: api,
          ),
        ],
        errors: () => [isA<DioError>()],
      );

      blocTest<LiplRestBloc, LiplRestState>(
        'load unauthorized',
        setUp: () {
          when(
            () => api.getLyrics(),
          ).thenThrow(unauthorized('lyric'));
          when(
            () => api.getPlaylists(),
          ).thenThrow(unauthorized('playlist'));
        },
        build: () => LiplRestBloc(),
        act: (bloc) {
          bloc.add(LiplRestEventLoad(api: api));
        },
        expect: () => [
          LiplRestState.initial().copyWith(
            status: LiplRestStatus.loading,
            api: api,
          ),
          LiplRestState.initial().copyWith(
            status: LiplRestStatus.unauthorized,
            api: api,
          )
        ],
        errors: () => [isA<DioError>()],
        verify: (_) {
          verify(
            () => api.getLyrics(),
          ).called(1);
          verifyNever(
            () => api.getPlaylists(),
          );
        },
      );

      blocTest<LiplRestBloc, LiplRestState>(
        'load plus add',
        setUp: () {
          when(
            () => api.postLyric(any()),
          ).thenThrow(
            DioError(
              requestOptions: RequestOptions(path: 'lyric/5'),
            ),
          );
        },
        build: () => LiplRestBloc(),
        seed: () => loaded(api),
        act: (bloc) => bloc.add(
          LiplRestEventPostLyric(
            lyricPost: addingLyric,
          ),
        ),
        wait: const Duration(milliseconds: 10),
        expect: () => [
          loaded(api).copyWith(
            status: LiplRestStatus.changing,
          )
        ],
        errors: () => [isA<DioError>()],
        verify: (_) {
          verify(
            () => api.postLyric(any()),
          ).called(1);
        },
      );

      blocTest<LiplRestBloc, LiplRestState>('load plus delete',
          setUp: () {
            when(
              () => api.deleteLyric(any<String>()),
            ).thenThrow(error('lyric/5'));
          },
          build: () => LiplRestBloc(),
          seed: () => loaded(api),
          act: (bloc) => bloc.add(
                LiplRestEventDeleteLyric(
                  id: '5',
                ),
              ),
          expect: () => [
                loaded(api).copyWith(status: LiplRestStatus.changing),
              ],
          errors: () => [isA<DioError>()],
          verify: (_) {
            verify(
              () => api.deleteLyric(any()),
            ).called(1);
          });

      blocTest<LiplRestBloc, LiplRestState>('load plus change',
          setUp: () {
            when(
              () => api.putLyric(any(), any()),
            ).thenThrow(error('lyric/5'));
          },
          build: () => LiplRestBloc(),
          seed: () => loaded(api),
          act: (bloc) => bloc.add(
                LiplRestEventPutLyric(
                  lyric: initialLyrics[1].copyWith(
                    title: () => 'Breng eens een emmer',
                  ),
                ),
              ),
          expect: () => [
                loaded(api).copyWith(status: LiplRestStatus.changing),
              ],
          errors: () => [isA<DioError>()],
          verify: (bloc) {
            verify(
              () => api.putLyric(any(), any()),
            ).called(1);
          });
    }); // end group Lyric Exceptions

    group('Playlist', () {
      late LiplRestApi api;

      setUp(() {
        api = MockApi();
      });

      blocTest<LiplRestBloc, LiplRestState>(
        'load plus add',
        setUp: () {
          when(
            () => api.postPlaylist(any<PlaylistPost>()),
          ).thenAnswer(
            (invocation) async => Playlist(
              id: '562',
              title: addingPlaylist.title,
              members: addingPlaylist.members,
            ),
          );
        },
        build: () => LiplRestBloc(),
        seed: () => loaded(api),
        act: (bloc) => bloc.add(
          LiplRestEventPostPlaylist(
            playlistPost: addingPlaylist,
          ),
        ),
        expect: () => [
          loaded(api).copyWith(status: LiplRestStatus.changing),
          loaded(api).copyWith(
            playlists: [
              ...initialPlaylists,
              Playlist(
                id: '562',
                title: addingPlaylist.title,
                members: addingPlaylist.members,
              )
            ].sortByTitle(),
          )
        ],
      );

      blocTest<LiplRestBloc, LiplRestState>(
        'load plus delete',
        setUp: () {
          when(
            () => api.deletePlaylist(any<String>()),
          ).thenAnswer((invocation) async {});
        },
        build: () => LiplRestBloc(),
        seed: () => loaded(api),
        act: (bloc) => bloc.add(
          LiplRestEventDeletePlaylist(
            id: '4',
          ),
        ),
        expect: () => [
          loaded(api).copyWith(status: LiplRestStatus.changing),
          loaded(api).copyWith(
              playlists: initialPlaylists
                  .sortByTitle()
                  .where((playlist) => playlist.id != '4')
                  .toList())
        ],
      );

      blocTest<LiplRestBloc, LiplRestState>(
        'load plus change',
        setUp: () {
          when(
            () => api.putPlaylist(any<String>(), any<Playlist>()),
          ).thenAnswer((invocation) async =>
              initialPlaylists[1].copyWith(title: () => 'Breng eens wat meer'));
        },
        build: () => LiplRestBloc(),
        seed: () => loaded(api),
        act: (bloc) => bloc.add(
          LiplRestEventPutPlaylist(
            playlist: initialPlaylists[1].copyWith(
              title: () => 'Breng eens wat meer',
            ),
          ),
        ),
        expect: () => [
          loaded(api).copyWith(status: LiplRestStatus.changing),
          loaded(api).copyWith(
            playlists: [
              initialPlaylists[0],
              initialPlaylists[1].copyWith(
                title: () => 'Breng eens wat meer',
              ),
            ].sortByTitle(),
          )
        ],
      );
    }); // end group Playlist

    group('Playlist Exceptions', () {
      late LiplRestApi api;

      setUp(() {
        api = MockApi();
      });

      blocTest<LiplRestBloc, LiplRestState>('load plus add',
          setUp: () {
            when(
              () => api.postPlaylist(any()),
            ).thenThrow(error('playlist'));
          },
          build: () => LiplRestBloc(),
          seed: () => loaded(api),
          act: (bloc) => bloc.add(
                LiplRestEventPostPlaylist(
                  playlistPost: addingPlaylist,
                ),
              ),
          expect: () => [
                loaded(api).copyWith(status: LiplRestStatus.changing),
              ],
          errors: () => [isA<DioError>()],
          verify: (_) {
            verify(
              () => api.postPlaylist(any()),
            ).called(1);
          });

      blocTest<LiplRestBloc, LiplRestState>('load plus delete',
          setUp: () {
            when(
              () => api.deletePlaylist(any()),
            ).thenThrow(error('playlist/4'));
          },
          build: () => LiplRestBloc(),
          seed: () => loaded(api),
          act: (bloc) => bloc.add(
                LiplRestEventDeletePlaylist(
                  id: '4',
                ),
              ),
          expect: () => [
                loaded(api).copyWith(status: LiplRestStatus.changing),
              ],
          errors: () => [isA<DioError>()],
          verify: (_) {
            verify(
              () => api.deletePlaylist(any()),
            ).called(1);
          });

      blocTest<LiplRestBloc, LiplRestState>('load plus change',
          setUp: () {
            when(
              () => api.putPlaylist(any(), any()),
            ).thenThrow(error('playlist/4'));
          },
          build: () => LiplRestBloc(),
          seed: () => loaded(api),
          act: (bloc) => bloc.add(
                LiplRestEventPutPlaylist(
                  playlist: initialPlaylists[1].copyWith(
                    title: () => 'Breng eens wat meer',
                  ),
                ),
              ),
          expect: () => [
                loaded(api).copyWith(status: LiplRestStatus.changing),
              ],
          errors: () => [isA<DioError>()],
          verify: (_) {
            verify(
              () => api.putPlaylist(any(), any()),
            ).called(1);
          });
    }); // end group Playlist Exceptions
  }); // end group LiplRestBloc
}
