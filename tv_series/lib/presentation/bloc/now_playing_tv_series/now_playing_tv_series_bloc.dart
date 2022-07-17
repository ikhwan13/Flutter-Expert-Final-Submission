import 'package:tv_series/tv_series.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc
    extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> {
  final GetOnAiring _getNowPlaying;
  NowPlayingTvSeriesBloc(this._getNowPlaying)
      : super(NowPlayingTvSeriesEmpty()) {
    on<NowPlayingTvSeries>((event, emit) async {
      emit(NowPlayingTvSeriesLoading());

      final result = await _getNowPlaying.execute();

      result.fold((failure) {
        emit(NowPlayingTvSeriesError(failure.message));
      }, (data) {
        data.isNotEmpty
            ? emit(NowPlayingTvSeriesHasData(data))
            : emit(NowPlayingTvSeriesEmpty());
      });
    });
  }
}
