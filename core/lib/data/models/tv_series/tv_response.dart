import 'package:core/data/models/tv_series/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvResponse extends Equatable {
  final List<TvModel> tvSeriesList;

  const TvResponse({required this.tvSeriesList});

  factory TvResponse.fromJson(Map<String, dynamic> json) =>
      TvResponse(
        tvSeriesList: List<TvModel>.from((json["results"] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvSeriesList];
}
