part of 'tv_series_search_bloc.dart';

abstract class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class TvSeriesOnQueryChanged extends TvSeriesSearchEvent {
  final String query;

  const TvSeriesOnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
