import 'package:tv_series/tv_series.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  final GetTvSeriesRecommendations _getTvSeriesRecommendation;
  TvSeriesRecommendationBloc(this._getTvSeriesRecommendation)
      : super(TvSeriesRecommendationEmpty()) {
    on<OnTvSeriesRecommendationCalled>((event, emit) async {
      final id = event.id;

      emit(TvSeriesRecommendationLoading());

      final result = await _getTvSeriesRecommendation.execute(id);

      result.fold(
        (failure) => emit(TvSeriesRecommendationError(failure.message)),
        (data) => data.isNotEmpty
            ? emit(TvSeriesRecommendationHasData(data))
            : emit(TvSeriesRecommendationEmpty()),
      );
    });
  }
}
