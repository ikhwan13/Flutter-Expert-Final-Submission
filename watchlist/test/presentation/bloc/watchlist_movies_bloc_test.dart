import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/movie/dummy_objects.dart';
import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchListStatus, GetWatchlistMovies, RemoveWatchlist, SaveWatchlist])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatusMovies;
  late MockRemoveWatchlist mockRemoveWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchlistMovies;
  late WatchlistMoviesBloc watchlistMoviesBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatusMovies = MockGetWatchListStatus();
    mockRemoveWatchlistMovies = MockRemoveWatchlist();
    mockSaveWatchlistMovies = MockSaveWatchlist();
    watchlistMoviesBloc = WatchlistMoviesBloc(
      mockGetWatchlistMovies,
      mockGetWatchListStatusMovies,
      mockRemoveWatchlistMovies,
      mockSaveWatchlistMovies,
    );
  });

  test('the WatchlistMoviesEmpty initial state should be empty ', () {
    expect(watchlistMoviesBloc.state, WatchlistMoviesEmpty());
  });

  group('get watchlist movies test cases', () {
    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emits WatchlistMovieLoading state and then WatchlistMovieHasData state when data is successfully fetched..',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMoviesCalled()),
      expect: () => [
        WatchlistMoviesLoading(),
        WatchlistMoviesHasData([testWatchlistMovie]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return OnWatchlistMoviesCalled().props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emits WatchlistMoviesLoading state and then WatchlistMoviesError state when data is failed fetched..',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMoviesCalled()),
      expect: () => <WatchlistMoviesState>[
        WatchlistMoviesLoading(),
        WatchlistMoviesError('Server Failure'),
      ],
      verify: (bloc) => WatchlistMoviesLoading(),
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emits WatchlistMoviesLoading state and then WatchlistMoviesEmpty state when data is retrieved empty..',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMoviesCalled()),
      expect: () => <WatchlistMoviesState>[
        WatchlistMoviesLoading(),
        WatchlistMoviesEmpty(),
      ],
    );
  });

  group('get watchlist status movies test cases', () {
    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should be return true when the watchlist is also true',
      build: () {
        when(mockGetWatchListStatusMovies.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovieStatus(testMovieDetail.id)),
      expect: () => [WatchlistMoviesIsAdded(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatusMovies.execute(testMovieDetail.id));
        return FetchWatchlistMovieStatus(testMovieDetail.id).props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
        'should be return false when the watchlist is also false',
        build: () {
          when(mockGetWatchListStatusMovies.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistMovieStatus(testMovieDetail.id)),
        expect: () => <WatchlistMoviesState>[
              WatchlistMoviesIsAdded(false),
            ],
        verify: (bloc) {
          verify(mockGetWatchListStatusMovies.execute(testMovieDetail.id));
          return FetchWatchlistMovieStatus(testMovieDetail.id).props;
        });
  });

  group('add watchlist test cases', () {
    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should update watchlist status when adding movie to watchlist is successfully',
      build: () {
        when(mockSaveWatchlistMovies.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMoviesMessage('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistMovies.execute(testMovieDetail));
        return AddMovieToWatchlist(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should throw failure message status when adding movie to watchlist is failed',
      build: () {
        when(mockSaveWatchlistMovies.execute(testMovieDetail)).thenAnswer(
            (_) async =>
                const Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMoviesError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistMovies.execute(testMovieDetail));
        return AddMovieToWatchlist(testMovieDetail).props;
      },
    );
  });

  group('remove watchlist test cases', () {
    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should update watchlist status when removing movie from watchlist is successfully',
      build: () {
        when(mockRemoveWatchlistMovies.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMoviesMessage('Removed from Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistMovies.execute(testMovieDetail));
        return RemoveMovieFromWatchlist(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should throw failure message status when removie movie from watchlist is failed',
      build: () {
        when(mockRemoveWatchlistMovies.execute(testMovieDetail)).thenAnswer(
            (_) async =>
                const Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMoviesError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistMovies.execute(testMovieDetail));
        return RemoveMovieFromWatchlist(testMovieDetail).props;
      },
    );
  });
}
