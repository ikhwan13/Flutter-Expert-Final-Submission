import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:movie/movie.dart';
import 'package:tv_series/tv_series.dart';

@GenerateMocks([
  MovieRepository,
  TvRepository,
  MoviesRemoteDataSource,
  TvRemoteDataSource,
  MovieLocalDataSource,
  TvLocalDataSource,
  MovieDatabaseHelper,
  DatabaseHelperTv
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
