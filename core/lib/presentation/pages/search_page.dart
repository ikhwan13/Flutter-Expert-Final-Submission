import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:search/presentation/page/movie_search_page.dart';
import 'package:search/presentation/page/tv_search_page.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/searchPage';

  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('Search'),
              pinned: true,
              floating: true,
              bottom: TabBar(
                indicatorColor: kMikadoYellow,
                tabs: [
                  _buildTabBarItem('Movies', Icons.movie),
                  _buildTabBarItem('TV Series', Icons.tv),
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: <Widget>[
            SearchPageMovies(),
            SearchPageTv(),
          ],
        ),
      )),
    );
  }

  Widget _buildTabBarItem(String title, IconData iconData) => Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData),
            const SizedBox(
              width: 12.0,
            ),
            Text(title),
          ],
        ),
      );
}
