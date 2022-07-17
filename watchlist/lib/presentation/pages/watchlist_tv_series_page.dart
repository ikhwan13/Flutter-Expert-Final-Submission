import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/watchlist.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  static const routeName = '/watchlist-tvseries';

  const WatchlistTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvSeriesPage> createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistTvSeriesBloc>().add(OnWatchlistTvSeriesCalled()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvSeriesBloc>().add(OnWatchlistTvSeriesCalled());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      builder: (context, state) {
        if (state is WatchlistTvSeriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WatchlistTvSeriesEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "You don't have any series yet, lets add some!",
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomePage.routeName,
                    (route) => false,
                  ),
                  child: const Text('Add Series'),
                ),
              ],
            ),
          );
        } else if (state is WatchlistTvSeriesHasData) {
          final watchlistTv = state.result;
          return ListView.builder(
            itemBuilder: (context, index) {
              final tv = watchlistTv[index];
              return TvSeriesCard(tv);
            },
            itemCount: watchlistTv.length,
          );
        } else {
          return const Center(
            key: Key('error_msg'),
            child: Text('Failed to fetch data'),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
