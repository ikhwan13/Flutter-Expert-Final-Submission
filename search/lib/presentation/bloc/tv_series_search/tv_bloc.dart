import 'package:search/search.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_event.dart';
part 'tv_state.dart';

EventTransformer<T> tvseriesDebounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTv _searchTvSeries;
  TvSeriesSearchBloc(this._searchTvSeries) : super(TvSeriesSearchEmpty()) {
    on<TvSeriesOnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(TvSeriesSearchLoading());

        final result = await _searchTvSeries.execute(query);

        result.fold(
          (failure) {
            emit(TvSeriesSearchError(failure.message));
          },
          (data) {
            emit(TvSeriesSearchHasData(data));
          },
        );
      },
      transformer: tvseriesDebounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}
