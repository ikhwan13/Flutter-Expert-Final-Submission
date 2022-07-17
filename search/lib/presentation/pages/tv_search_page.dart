import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:search/search.dart';

class SearchPageTv extends StatelessWidget {
  static const routeName = '/search-tv';

  const SearchPageTv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (query) {
              context
                  .read<TvSeriesSearchBloc>()
                  .add(TvSeriesOnQueryChanged(query));
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Search Result',
            style: kHeading6,
          ),
          BlocBuilder<TvSeriesSearchBloc, TvSeriesSearchState>(
            builder: (context, state) {
              if (state is TvSeriesSearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvSeriesSearchHasData) {
                final result = state.result;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final tv = result[index];
                      return TvCard(tv);
                    },
                    itemCount: result.length,
                  ),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
