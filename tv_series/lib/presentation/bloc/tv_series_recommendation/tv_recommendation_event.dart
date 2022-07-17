part of 'tv_recommendation_bloc.dart';

abstract class TvSeriesRecommendationEvent extends Equatable {}

class OnTvSeriesRecommendationCalled extends TvSeriesRecommendationEvent {
  final int id;

  OnTvSeriesRecommendationCalled(this.id);

  @override
  List<Object?> get props => [id];
}
