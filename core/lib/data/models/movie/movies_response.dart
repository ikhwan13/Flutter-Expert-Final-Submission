import 'package:core/data/models/movie/movies_model.dart';
import 'package:equatable/equatable.dart';

class MovieResponse extends Equatable {
  final List<MoviesModel> movieList;

  const MovieResponse({required this.movieList});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        movieList: List<MoviesModel>.from((json["results"] as List)
            .map((x) => MoviesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(movieList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [movieList];
}
