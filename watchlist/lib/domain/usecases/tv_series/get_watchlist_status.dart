import 'package:tv_series/tv_series.dart';

class GetWatchListStatusTv {
  final TvRepository repository;

  GetWatchListStatusTv(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTvSeries(id);
  }
}
