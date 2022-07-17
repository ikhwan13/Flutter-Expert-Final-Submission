import 'package:dartz/dartz.dart';
import 'package:tv_series/tv_series.dart';
import 'package:core/core.dart';

class SearchTv {
  final TvSeriesRepository repository;

  SearchTv(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTv(query);
  }
}
