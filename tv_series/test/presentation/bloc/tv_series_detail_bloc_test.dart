import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object_tv_series.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late TvSeriesDetailBloc tvSeriesDetailBloc;

  const testId = 1;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesDetailBloc = TvSeriesDetailBloc(mockGetTvSeriesDetail);
  });
  test('the TvseriesDetailBloc initial state should be empty', () {
    expect(tvSeriesDetailBloc.state, TvSeriesDetailEmpty());
  });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emits TvseriesDetailLoading state and then TvseriesDetailHasData state when data is successfully fetched.',
      build: () {
        when(mockGetTvSeriesDetail.execute(testId))
            .thenAnswer((_) async => const Right(testTvDetail));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnTvSeriesDetailCalled(testId)),
      expect: () => <TvSeriesDetailState>[
            TvSeriesDetailLoading(),
            TvSeriesDetailHasData(testTvDetail),
          ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(testId));
        return OnTvSeriesDetailCalled(testId).props;
      });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'should emits TvseriesDetailLoading state and TvseriesDetailError when data is failed to fetch.',
    build: () {
      when(mockGetTvSeriesDetail.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(OnTvSeriesDetailCalled(testId)),
    expect: () => <TvSeriesDetailState>[
      TvSeriesDetailLoading(),
      TvSeriesDetailError('Server Failure'),
    ],
    verify: (bloc) => TvSeriesDetailLoading(),
  );
}
