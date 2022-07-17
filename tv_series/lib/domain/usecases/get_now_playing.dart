import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';

class GetNowPlaying {
  final TvSeriesRepository repository;

  GetNowPlaying(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getNowPlaying();
  }
}
