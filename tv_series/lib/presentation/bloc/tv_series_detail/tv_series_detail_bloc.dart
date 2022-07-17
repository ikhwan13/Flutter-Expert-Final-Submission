import 'package:tv_series/tv_series.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail _getTvSeriesDetail;
  TvSeriesDetailBloc(this._getTvSeriesDetail) : super(TvSeriesDetailEmpty()) {
    on<OnTvSeriesDetailCalled>((event, emit) async {
      final id = event.id;

      emit(TvSeriesDetailLoading());

      final result = await _getTvSeriesDetail.execute(id);

      result.fold((failure) => emit(TvSeriesDetailError(failure.message)),
          (data) => emit(TvSeriesDetailHasData(data)));
    });
  }
}
