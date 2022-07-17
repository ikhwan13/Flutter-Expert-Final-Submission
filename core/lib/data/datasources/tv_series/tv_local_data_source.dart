import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/db/database_helper_tv.dart';
import 'package:core/data/models/tv_series/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlistTvSeries(TvTable tv);
  Future<String> removeWatchlistTvSeries(TvTable tv);
  Future<TvTable?> getTvSeriesById(int id);
  Future<List<TvTable>> getWatchlistTvSeries();
}

class TvSeriesLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelperTv databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistTvSeries(TvTable tv) async {
    try {
      await databaseHelper.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTvSeries(TvTable tv) async {
    try {
      await databaseHelper.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }
}
