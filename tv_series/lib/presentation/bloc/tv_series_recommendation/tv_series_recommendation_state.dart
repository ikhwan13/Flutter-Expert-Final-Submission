part of 'tv_series_recommendation_bloc.dart';

abstract class TvSeriesRecommendationState extends Equatable {}

class TvSeriesRecommendationEmpty extends TvSeriesRecommendationState {
  @override
  List<Object?> get props => [];
}

class TvSeriesRecommendationLoading extends TvSeriesRecommendationState {
  @override
  List<Object?> get props => [];
}

class TvSeriesRecommendationError extends TvSeriesRecommendationState {
  final String message;
  TvSeriesRecommendationError(this.message);
  @override
  List<Object?> get props => [message];
}

class TvSeriesRecommendationHasData extends TvSeriesRecommendationState {
  final List<Tv> result;
  TvSeriesRecommendationHasData(this.result);
  @override
  List<Object?> get props => [result];
}
