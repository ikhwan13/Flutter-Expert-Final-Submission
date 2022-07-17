import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:tv_series/tv_series.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    const MovieHomePage(),
    const TvSeriesHomePage(),
    const WatchlistPage(),
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SalomonBottomBar(
          currentIndex: currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.movie),
              title: const Text("Movies"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.tv),
              title: const Text("TV Series"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.save_alt),
              title: const Text("Watchlist"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.info_outline),
              title: const Text("About"),
            ),
          ],
        ),
      ),
    );
  }
}
