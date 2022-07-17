import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries usecase;
  late MockTvSeriesRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(mockTvRepository);
  });

  final tTv = <TvSeries>[];

  test('should get list of tv from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTvSeries())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTv));
  });
}
