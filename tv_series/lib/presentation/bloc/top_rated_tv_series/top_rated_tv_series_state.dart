part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTvSeriesState extends Equatable {}

class TopRatedTvSeriesEmpty extends TopRatedTvSeriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedTvSeriesError extends TopRatedTvSeriesState {
  final String message;
  TopRatedTvSeriesError(this.message);
  @override
  List<Object?> get props => [message];
}

class TopRatedTvSeriesHasData extends TopRatedTvSeriesState {
  final List<Tv> result;
  TopRatedTvSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
