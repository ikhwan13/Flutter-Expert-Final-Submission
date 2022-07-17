part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {}

class OnWatchlistTvSeriesCalled extends WatchlistTvSeriesEvent {
  @override
  List<Object?> get props => [];
}

class FetchWatchlistTvSeriesStatus extends WatchlistTvSeriesEvent {
  final int id;
  FetchWatchlistTvSeriesStatus(this.id);
  @override
  List<Object?> get props => [id];
}

class AddTvSeriesToWatchlist extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvseries;
  AddTvSeriesToWatchlist(this.tvseries);
  @override
  List<Object?> get props => [tvseries];
}

class RemoveTvSeriesFromWatchlist extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvseries;
  RemoveTvSeriesFromWatchlist(this.tvseries);
  @override
  List<Object?> get props => [tvseries];
}
