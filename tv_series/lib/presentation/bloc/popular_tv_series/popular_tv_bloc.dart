import 'package:tv_series/tv_series.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries _getPopularTvSeries;
  PopularTvSeriesBloc(this._getPopularTvSeries)
      : super(PopularTvSeriesEmpty()) {
    on<OnPopularTvSeriesCalled>((event, emit) async {
      emit(PopularTvSeriesLoading());

      final result = await _getPopularTvSeries.execute();

      result.fold(
        (failure) => emit(PopularTvSeriesError(failure.message)),
        (data) => data.isNotEmpty
            ? emit(PopularTvSeriesHasData(data))
            : emit(PopularTvSeriesEmpty()),
      );
    });
  }
}
