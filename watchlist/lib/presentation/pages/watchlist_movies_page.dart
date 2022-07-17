import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/watchlist.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';

  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistMoviesBloc>().add(OnWatchlistMoviesCalled()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(OnWatchlistMoviesCalled());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
          builder: (context, state) {
        if (state is WatchlistMoviesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WatchlistMoviesHasData) {
          final watchlistMovies = state.result;
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = watchlistMovies[index];
              return MovieCard(movie);
            },
            itemCount: watchlistMovies.length,
          );
        } else if (state is WatchlistMoviesEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "You don't have any movies yet, lets add some!",
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomePage.routeName,
                    (route) => false,
                  ),
                  child: const Text('Add Movie'),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            key: Key('error_msg'),
            child: Text('Failed to fetch data'),
          );
        }
      }),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
