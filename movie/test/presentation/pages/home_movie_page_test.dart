import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/page_test_helper.dart';

void main() {
  late FakeNowPlayingMoviesBloc fakeNowPlayingMoviesBloc;
  late FakePopularMoviesBloc fakePopularMovieBloc;
  late FakeTopRatedMoviesBloc fakeTopRatedMovieBloc;

  setUp(() {
    fakeNowPlayingMoviesBloc = FakeNowPlayingMoviesBloc();
    registerFallbackValue(FakeNowPlayingMoviesEvent());
    registerFallbackValue(FakeNowPlayingMoviesState());

    fakePopularMovieBloc = FakePopularMoviesBloc();
    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());

    fakeTopRatedMovieBloc = FakeTopRatedMoviesBloc();
    registerFallbackValue(FakeTopRatedMoviesEvent());
    registerFallbackValue(FakeTopRatedMoviesState());

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeNowPlayingMoviesBloc.close();
    fakePopularMovieBloc.close();
    fakeTopRatedMovieBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMovieBloc>(
          create: (context) => fakeNowPlayingMoviesBloc,
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => fakeTopRatedMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets(
      'page should display listview of NowPlayingMovies when HasData state is happen',
          (WidgetTester tester) async {
        when(() => fakeNowPlayingMoviesBloc.state)
            .thenReturn(NowPlayingMovieHasData(testMovieList));
        when(() => fakePopularMovieBloc.state)
            .thenReturn(PopularMoviesHasData(testMovieList));
        when(() => fakeTopRatedMovieBloc.state)
            .thenReturn(TopRatedMoviesHasData(testMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_createTestableWidget(const HomeMoviesPage()));

        expect(listViewFinder, findsWidgets);
      });
}
