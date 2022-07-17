import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object_tv.dart';
import 'tv_series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late TvSeriesRecommendationBloc tvSeriesRecommendationBloc;

  const testId = 1;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvSeriesRecommendationBloc =
        TvSeriesRecommendationBloc(mockGetTvSeriesRecommendations);
  });

  test('the TvseriesRecommendationsEmpty initial state should be empty ', () {
    expect(tvSeriesRecommendationBloc.state, TvSeriesRecommendationEmpty());
  });

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'should emits PopularTvseriesLoading state and then PopularTvseriesHasData state when data is successfully fetched..',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testTvList));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnTvSeriesRecommendationCalled(testId)),
    expect: () => <TvSeriesRecommendationState>[
      TvSeriesRecommendationLoading(),
      TvSeriesRecommendationHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetTvSeriesRecommendations.execute(testId)),
  );

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'should emits TvseriesRecommendationsLoading state and then TvseriesRecommendationsError state when data is failed fetched..',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnTvSeriesRecommendationCalled(testId)),
    expect: () => <TvSeriesRecommendationState>[
      TvSeriesRecommendationLoading(),
      TvSeriesRecommendationError('Server Failure'),
    ],
    verify: (bloc) => TvSeriesRecommendationLoading(),
  );

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'should emits TvseriesRecommendationsLoading state and then TvseriesRecommendationsEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnTvSeriesRecommendationCalled(testId)),
    expect: () => <TvSeriesRecommendationState>[
      TvSeriesRecommendationLoading(),
      TvSeriesRecommendationEmpty(),
    ],
  );
}
