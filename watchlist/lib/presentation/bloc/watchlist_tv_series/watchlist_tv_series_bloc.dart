import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries _getWatchlistTvSeries;
  final GetWatchListStatusTvSeries _getWatchListStatusTvSeries;
  final RemoveWatchlistTvSeries _removeWatchlistTvSeries;
  final SaveWatchlistTvSeries _saveWatchlistTvSeries;
  WatchlistTvSeriesBloc(
    this._getWatchlistTvSeries,
    this._getWatchListStatusTvSeries,
    this._removeWatchlistTvSeries,
    this._saveWatchlistTvSeries,
  ) : super(WatchlistTvSeriesEmpty()) {
    on<OnWatchlistTvSeriesCalled>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      final result = await _getWatchlistTvSeries.execute();
      result.fold(
        (failure) => emit(WatchlistTvSeriesError(failure.message)),
        (data) => data.isNotEmpty
            ? emit(WatchlistTvSeriesHasData(data))
            : emit(WatchlistTvSeriesEmpty()),
      );
    });

    on<FetchWatchlistTvSeriesStatus>(((event, emit) async {
      final id = event.id;

      final result = await _getWatchListStatusTvSeries.execute(id);

      emit(WatchlistTvSeriesIsAdded(result));
    }));

    on<AddTvSeriesToWatchlist>(
      ((event, emit) async {
        final movie = event.tvseries;

        final result = await _saveWatchlistTvSeries.execute(movie);

        result.fold(
          (failure) => emit(WatchlistTvSeriesError(failure.message)),
          (message) => emit(
            WatchlistTvSeriesMessage(message),
          ),
        );
      }),
    );

    on<RemoveTvSeriesFromWatchlist>(
      ((event, emit) async {
        final tvseries = event.tvseries;

        final result = await _removeWatchlistTvSeries.execute(tvseries);

        result.fold(
          (failure) => emit(WatchlistTvSeriesError(failure.message)),
          (message) => emit(
            WatchlistTvSeriesMessage(message),
          ),
        );
      }),
    );
  }
}
