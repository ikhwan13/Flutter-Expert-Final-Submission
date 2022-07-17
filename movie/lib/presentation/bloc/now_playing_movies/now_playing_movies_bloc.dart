import 'package:movie/movie.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieBloc(this.getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<OnNowPlayingMovieCalled>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(NowPlayingMovieError(failure.message));
      }, (data) {
        data.isEmpty
            ? emit(NowPlayingMovieEmpty())
            : emit(NowPlayingMovieHasData(data));
      });
    });
  }
}
