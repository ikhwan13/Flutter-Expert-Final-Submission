import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object_tv.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvSeriesBloc popularTvSeriesBloc;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
  });

  test('the PopularTvseriesEmpty initial state should be empty ', () {
    expect(popularTvSeriesBloc.state, PopularTvSeriesEmpty());
  });

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'should emits PopularTvseriesLoading state and then PopularTvseriesHasData state when data is successfully fetched..',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvSeriesCalled()),
    expect: () => <PopularTvSeriesState>[
      PopularTvSeriesLoading(),
      PopularTvSeriesHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetPopularTvSeries.execute()),
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'should emits PopularTvseriesLoading state and then PopularTvseriesError state when data is failed fetched..',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvSeriesCalled()),
    expect: () => <PopularTvSeriesState>[
      PopularTvSeriesLoading(),
      PopularTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => PopularTvSeriesLoading(),
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'should emits PopularTvseriesLoading state and then PopularTvseriesEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvSeriesCalled()),
    expect: () => <PopularTvSeriesState>[
      PopularTvSeriesLoading(),
      PopularTvSeriesEmpty(),
    ],
  );
}
