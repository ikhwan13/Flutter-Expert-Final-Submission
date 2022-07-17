import 'package:core/core.dart';
import 'package:search/search.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search-page';

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
                    indicatorColor: kDavysGrey,
                    tabs: [
                      _buildTabBarItem('Movies', Icons.movie),
                      _buildTabBarItem('TV Series', Icons.live_tv),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
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
