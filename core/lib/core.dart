library core;

export 'package:google_fonts/google_fonts.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:equatable/equatable.dart';
export 'package:core/data/datasources/db/database_helper_movies.dart';
export 'package:core/data/datasources/db/database_helper_tv.dart';
export 'package:core/data/datasources/movie/movies_local_data_source.dart';
export 'package:core/data/datasources/movie/movies_remote_data_source.dart';
export 'package:core/data/datasources/tv_series/tv_local_data_source.dart';
export 'package:core/data/datasources/tv_series/tv_remote_data_source.dart';
export 'package:core/data/models/genre_model.dart';
export 'package:core/data/models/movie/movies_detail_model.dart';
export 'package:core/data/models/movie/movies_model.dart';
export 'package:core/data/models/movie/movies_response.dart';
export 'package:core/data/models/movie/movies_table.dart';
export 'package:core/data/models/tv_series/tv_detail_model.dart';
export 'package:core/data/models/tv_series/tv_model.dart';
export 'package:core/data/models/tv_series/tv_response.dart';
export 'package:core/data/models/tv_series/tv_table.dart';
export 'package:core/data/repositories/movies_repository_impl.dart';
export 'package:core/data/repositories/tv_repository_impl.dart';
export 'package:core/domain/entities/genre.dart';
export 'package:core/presentation/pages/home_page.dart';
export 'package:core/presentation/pages/search_page.dart';
export 'package:core/presentation/pages/watchlist_page.dart';
export 'package:core/presentation/widgets/movies_card_list.dart';
export 'package:core/presentation/widgets/sub_heading.dart';
export 'package:core/presentation/widgets/tv_card.dart';
export 'styles/colors.dart';
export 'styles/text_styles.dart';
export 'utils/constants.dart';
export 'utils/exception.dart';
export 'utils/failure.dart';
export 'utils/state_enum.dart';
export 'utils/utils.dart';