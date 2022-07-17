part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {}

class OnWatchlistMoviesCalled extends WatchlistMoviesEvent {
  @override
  List<Object?> get props => [];
}

class FetchWatchlistMovieStatus extends WatchlistMoviesEvent {
  final int id;
  FetchWatchlistMovieStatus(this.id);
  @override
  List<Object?> get props => [id];
}

class AddMovieToWatchlist extends WatchlistMoviesEvent {
  final MovieDetail movieDetail;
  AddMovieToWatchlist(this.movieDetail);
  @override
  List<Object?> get props => [movieDetail];
}

class RemoveMovieFromWatchlist extends WatchlistMoviesEvent {
  final MovieDetail movieDetail;
  RemoveMovieFromWatchlist(this.movieDetail);
  @override
  List<Object?> get props => [movieDetail];
}
