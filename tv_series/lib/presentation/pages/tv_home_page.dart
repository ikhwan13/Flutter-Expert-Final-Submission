import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';

class TvHomePage extends StatefulWidget {
  const TvHomePage({Key? key}) : super(key: key);
  static const routeName = '/tv-page';

  @override
  State<TvHomePage> createState() => _TvHomePageState();
}

class _TvHomePageState extends State<TvHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvSeriesBloc>().add(NowPlayingTvSeries());
      context.read<PopularTvSeriesBloc>().add(OnPopularTvSeriesCalled());
      context.read<TopRatedTvSeriesBloc>().add(OnTopRatedTvSeriesCalled());
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
                  'Airing Today',
                  style: kHeading6,
                ),
                BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
                    builder: (context, state) {
                      if (state is NowPlayingTvSeriesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is NowPlayingTvSeriesHasData) {
                        final data = state.result;
                        return TvList(data);
                      } else if (state is NowPlayingTvSeriesError) {
                        return const Text(
                          'Failed to fetch data',
                          key: Key('error_msg'),
                        );
                      } else {
                        return Container();
                      }
                    }),
                SubHeading(
                    title: 'Popular',
                    onTap: () {
                      Navigator.pushNamed(
                          context, PopularTvPage.routeName);
                    }),
                BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
                    builder: (context, state) {
                      if (state is PopularTvSeriesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is PopularTvSeriesHasData) {
                        final data = state.result;
                        return TvList(data);
                      } else if (state is PopularTvSeriesError) {
                        return const Text(
                          'Failed to fetch data',
                          key: Key('error_msg'),
                        );
                      } else {
                        return Container();
                      }
                    }),
                SubHeading(
                    title: 'Top Rated',
                    onTap: () {
                      Navigator.pushNamed(
                          context, TopRatedTvPage.routeName);
                    }),
                BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
                    builder: (context, state) {
                      if (state is TopRatedTvSeriesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TopRatedTvSeriesHasData) {
                        final data = state.result;
                        return TvList(data);
                      } else if (state is TopRatedTvSeriesError) {
                        return const Text(
                          'Failed to fetch data',
                          key: Key('error_msg'),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvSeries;

  const TvList(this.tvSeries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.routeName,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: '$baseImageUrl${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
