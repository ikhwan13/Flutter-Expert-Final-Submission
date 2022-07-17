import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:get_it/get_it.dart';
import 'package:search/search.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // BLoC Movies
  locator.registerFactory<NowPlayingMovieBloc>(
      () => NowPlayingMovieBloc(locator()));
  locator
      .registerFactory<PopularMoviesBloc>(() => PopularMoviesBloc(locator()));
  locator
      .registerFactory<TopRatedMoviesBloc>(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory<MovieDetailBloc>(() => MovieDetailBloc(locator()));
  locator.registerFactory<MovieSearchBloc>(() => MovieSearchBloc(locator()));
  locator.registerFactory<MovieRecommendationsBloc>(
      () => MovieRecommendationsBloc(locator()));
  locator.registerFactory<WatchlistMoviesBloc>(
      () => WatchlistMoviesBloc(locator(), locator(), locator(), locator()));

  //BLoC Tv Series
  locator.registerFactory<NowPlayingTvSeriesBloc>(
      () => NowPlayingTvSeriesBloc(locator()));
  locator.registerFactory<PopularTvSeriesBloc>(
      () => PopularTvSeriesBloc(locator()));
  locator.registerFactory<TopRatedTvSeriesBloc>(
      () => TopRatedTvSeriesBloc(locator()));
  locator
      .registerFactory<TvSeriesDetailBloc>(() => TvSeriesDetailBloc(locator()));
  locator
      .registerFactory<TvSeriesSearchBloc>(() => TvSeriesSearchBloc(locator()));
  locator.registerFactory<TvSeriesRecommendationBloc>(
      () => TvSeriesRecommendationBloc(locator()));
  locator.registerFactory<WatchlistTvSeriesBloc>(
      () => WatchlistTvSeriesBloc(locator(), locator(), locator(), locator()));

  // Movie use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // Tv Series use case
  locator.registerLazySingleton(() => GetNowPlaying(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));

  // Movie repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // Tv Series repository
  locator.registerLazySingleton<TvSeriesRepository>(() =>
      TvSeriesRepositoryImpl(
          remoteDataSource: locator(), localDataSource: locator()));

  // Movie data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // Tv Series data sources
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // Movie databaseHelper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // Tv Series databaseHelper
  locator.registerLazySingleton<DatabaseHelperTvSeries>(
      () => DatabaseHelperTvSeries());

  // external
  locator.registerLazySingleton(() => SSLHelper.client);
}
