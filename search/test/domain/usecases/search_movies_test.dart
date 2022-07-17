import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/helper_test.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockTvSeriesRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvSeriesRepository();
    usecase = SearchTv(mockTvRepository);
  });

  final tTv = <Tv>[];
  const tQuery = 'game of thrones';

  test('should get list of TV Series from the repository', () async {
    // arrange
    when(mockTvRepository.searchTv(tQuery)).thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTv));
  });
}
