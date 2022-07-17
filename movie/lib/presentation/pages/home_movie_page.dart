import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({Key? key}) : super(key: key);

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingMovieBloc>(context, listen: false)
          .add(OnNowPlayingMovieCalled());
      BlocProvider.of<TopRatedMoviesBloc>(context, listen: false)
          .add(OnTopRatedMoviesCalled());
      BlocProvider.of<PopularMoviesBloc>(context, listen: false)
          .add(OnPopularMoviesCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ditonton',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Movies Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
                  builder: (context, state) {
                if (state is NowPlayingMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingMovieHasData) {
                  final data = state.result;
                  return MovieList(data);
                } else if (state is NowPlayingMovieError) {
                  return const Text(
                    'Failed to fetch data',
                    key: Key('error_message'),
                  );
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Popular Movies',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                  builder: (context, state) {
                if (state is NowPlayingMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMoviesHasData) {
                  return MovieList(state.result);
                } else if (state is PopularMoviesError) {
                  return Text(state.message);
                } else {
                  return const Center();
                }
              }),
              _buildSubHeading(
                title: 'Top Rated Movies',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                  builder: (context, state) {
                if (state is TopRatedMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMoviesHasData) {
                  return MovieList(state.result);
                } else if (state is TopRatedMoviesError) {
                  return Text(state.message);
                } else {
                  return const Center();
                }
              }),
            ],
          ),
        ),
      ),
    ));
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
