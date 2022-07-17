import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/watchlist.dart';

class WatchlistPage extends StatelessWidget {
  static const routeName = '/watchlistPage';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text('Watchlist'),
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
          body: const TabBarView(
            children: <Widget>[
              MoviesWatchlistPage(),
              TvWatchlistPage(),
            ],
          ),
        ),
      ),
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
