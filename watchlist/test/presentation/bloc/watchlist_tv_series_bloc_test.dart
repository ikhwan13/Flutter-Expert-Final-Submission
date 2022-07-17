import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/tv_series/dummy_object_tv.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatusTv,
  GetWatchlistTv,
  RemoveWatchlistTv,
  SaveWatchlistTv
])
void main() {
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
      mockGetWatchlistTvSeries,
      mockGetWatchListStatusTvSeries,
      mockRemoveWatchlistTvSeries,
      mockSaveWatchlistTvSeries,
    );
  });

  test('the WatchlisttvSeriesEmpty initial state should be empty ', () {
    expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesEmpty());
  });

  group('get watchlist movies test cases', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emits WatchlistMovieLoading state and then WatchlistMovieHasData state when data is successfully fetched..',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right([testWatchlistTv]));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvSeriesCalled()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesHasData([testWatchlistTv]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
        return OnWatchlistTvSeriesCalled().props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emits WatchlistMoviesLoading state and then WatchlistMoviesError state when data is failed fetched..',
      build: () {
        when(mockGetWatchlistTvSeries.execute()).thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvSeriesCalled()),
      expect: () => <WatchlistTvSeriesState>[
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTvSeriesLoading(),
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emits WatchlistMoviesLoading state and then WatchlistMoviesEmpty state when data is retrieved empty..',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvSeriesCalled()),
      expect: () => <WatchlistTvSeriesState>[
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesEmpty(),
      ],
    );
  });

  group('get watchlist status movies test cases', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should be return true when the watchlist is also true',
      build: () {
        when(mockGetWatchListStatusTvSeries.execute(testTvDetail.id))
            .thenAnswer((_) async => true);
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeriesStatus(testTvDetail.id)),
      expect: () => [WatchlistTvSeriesIsAdded(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatusTvSeries.execute(testTvDetail.id));
        return FetchWatchlistTvSeriesStatus(testTvDetail.id).props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should be return false when the watchlist is also false',
        build: () {
          when(mockGetWatchListStatusTvSeries.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return watchlistTvSeriesBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistTvSeriesStatus(testTvDetail.id)),
        expect: () => <WatchlistTvSeriesState>[
          WatchlistTvSeriesIsAdded(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatusTvSeries.execute(testTvDetail.id));
          return FetchWatchlistTvSeriesStatus(testTvDetail.id).props;
        });
  });

  group('add watchlist test cases', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should update watchlist status when adding movie to watchlist is successfully',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(AddTvSeriesToWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvSeriesMessage('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvDetail));
        return AddTvSeriesToWatchlist(testTvDetail).props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should throw failure message status when adding movie to watchlist is failed',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvDetail)).thenAnswer(
                (_) async =>
            const Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(AddTvSeriesToWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvSeriesError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvDetail));
        return AddTvSeriesToWatchlist(testTvDetail).props;
      },
    );
  });

  group('remove watchlist test cases', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should update watchlist status when removing movie from watchlist is successfully',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(RemoveTvSeriesFromWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvSeriesMessage('Removed from Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvDetail));
        return RemoveTvSeriesFromWatchlist(testTvDetail).props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should throw failure message status when removie movie from watchlist is failed',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvDetail)).thenAnswer(
                (_) async =>
            const Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(RemoveTvSeriesFromWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvSeriesError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvDetail));
        return RemoveTvSeriesFromWatchlist(testTvDetail).props;
      },
    );
  });
}
