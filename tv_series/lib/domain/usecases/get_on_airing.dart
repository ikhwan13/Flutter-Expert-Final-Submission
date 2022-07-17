import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';

class GetOnAiring {
  final TvRepository repository;

  GetOnAiring(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlaying();
  }
}
