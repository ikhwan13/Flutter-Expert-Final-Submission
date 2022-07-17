import 'package:tv_series/tv_series.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTv _getTopRatedTvSeries;
  TopRatedTvSeriesBloc(this._getTopRatedTvSeries)
      : super(TopRatedTvSeriesEmpty()) {
    on<OnTopRatedTvSeriesCalled>((event, emit) async {
      emit(TopRatedTvSeriesLoading());
      final result = await _getTopRatedTvSeries.execute();

      result.fold(
            (failure) => emit(TopRatedTvSeriesError(failure.message)),
            (data) => data.isNotEmpty
            ? emit(TopRatedTvSeriesHasData(data))
            : emit(TopRatedTvSeriesEmpty()),
      );
    });
  }
}
