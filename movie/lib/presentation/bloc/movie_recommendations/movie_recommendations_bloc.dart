import 'package:movie/movie.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations _getMovieRecommendations;
  MovieRecommendationsBloc(this._getMovieRecommendations)
      : super(MovieRecommendationsEmpty()) {
    on<OnMovieRecommendationsCalled>((event, emit) async {
      final id = event.id;

      emit(MovieRecommendationsLoading());

      final result = await _getMovieRecommendations.execute(id);

      result.fold(
        (failure) => emit(MovieRecommendationsError(failure.message)),
        (data) => data.isNotEmpty
            ? emit(MovieRecommendationsHasData(data))
            : emit(MovieRecommendationsEmpty()),
      );
    });
  }
}
