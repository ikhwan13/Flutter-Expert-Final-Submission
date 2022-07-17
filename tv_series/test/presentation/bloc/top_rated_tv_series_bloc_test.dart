import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object_tv_series.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);
  });

  test('the TopRatedTvseriesEmpty initial state should be empty ', () {
    expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesEmpty());
  });

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'should emits PopularTvseriesLoading state and then PopularTvseriesHasData state when data is successfully fetched..',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvSeriesCalled()),
    expect: () => <TopRatedTvSeriesState>[
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetTopRatedTvSeries.execute()),
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'should emits TopRatedTvseriesLoading state and then TopRatedTvseriesError state when data is failed fetched..',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvSeriesCalled()),
    expect: () => <TopRatedTvSeriesState>[
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => TopRatedTvSeriesLoading(),
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'should emits TopRatedTvseriesLoading state and then TopRatedTvseriesEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvSeriesCalled()),
    expect: () => <TopRatedTvSeriesState>[
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesEmpty(),
    ],
  );
}
