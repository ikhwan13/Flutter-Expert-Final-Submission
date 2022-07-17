import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getNowPlaying();
  Future<Either<Failure, List<Tv>>> getPopularTvSeries();
  Future<Either<Failure, List<Tv>>> getTopRatedTvSeries();
  Future<Either<Failure, TvDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, String>> saveWatchlistTvSeries(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlistTvSeries(TvDetail tv);
  Future<bool> isAddedToWatchlistTvSeries(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTvSeries();
  Future<Either<Failure, List<Tv>>> searchTv(String query);
}
