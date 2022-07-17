import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/tv_series.dart';

class TopRatedTvPage extends StatefulWidget {
  static const routeName = '/toprated-tv';

  const TopRatedTvPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TopRatedTvSeriesBloc>().add(OnTopRatedTvSeriesCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TvSeries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
          builder: (context, state) {
            if (state is TopRatedTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvSeriesHasData) {
              final tvSeries = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = tvSeries[index];
                  return TvCard(tv);
                },
                itemCount: tvSeries.length,
              );
            } else {
              return Center(
                key: const Key('error_msg'),
                child: Text((state as TopRatedTvSeriesError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
