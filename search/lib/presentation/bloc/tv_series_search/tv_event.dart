part of 'tv_bloc.dart';

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
