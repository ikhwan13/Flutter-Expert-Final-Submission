import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object_tv.dart';
import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetOnAiring])
void main() {
  late MockGetNowPlaying mockGetNowPlaying;
  late NowPlayingTvSeriesBloc nowPlayingTvSeriesBloc;

  setUp(() {
    mockGetNowPlaying = MockGetNowPlaying();
    nowPlayingTvSeriesBloc = NowPlayingTvSeriesBloc(mockGetNowPlaying);
  });

  test('the OnTheAirTvseriesBloc initial state should be empty ', () {
    expect(nowPlayingTvSeriesBloc.state, NowPlayingTvSeriesEmpty());
  });

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
      'should emits OnTheAirTvseriesLoading state and then OnTheAirTvseriesHasData state when data is successfully fetched..',
      build: () {
        when(mockGetNowPlaying.execute())
            .thenAnswer((_) async => Right(testTvList));
        return nowPlayingTvSeriesBloc;
      },
      act: (bloc) => bloc.add(NowPlayingTvSeries()),
      expect: () => <NowPlayingTvSeriesState>[
        NowPlayingTvSeriesLoading(),
        NowPlayingTvSeriesHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlaying.execute());
        return NowPlayingTvSeries().props;
      });

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'should emits OnTheAirTvseriesLoading state and then OnTheAirTvseriesError state when data is failed fetched..',
    build: () {
      when(mockGetNowPlaying.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingTvSeriesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTvSeries()),
    expect: () => <NowPlayingTvSeriesState>[
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingTvSeriesLoading(),
  );

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'should emits OnTheAirTvseriesLoading state and then OnTheAirTvseriesEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetNowPlaying.execute())
          .thenAnswer((_) async => const Right([]));
      return nowPlayingTvSeriesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTvSeries()),
    expect: () => <NowPlayingTvSeriesState>[
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesEmpty(),
    ],
  );
}
