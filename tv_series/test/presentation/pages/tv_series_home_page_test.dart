import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object_tv.dart';
import '../../helpers/page_test_helper.dart';

void main() {
  late FakeNowPlayingTvSeriesBloc fakeNowPlayingTvSeriesBloc;
  late FakePopularTvSeriesBloc fakePopularTvSeriesBloc;
  late FakeTopRatedTvSeriesBloc fakeTopRatedTvSeriesBloc;

  setUp(() {
    fakeNowPlayingTvSeriesBloc = FakeNowPlayingTvSeriesBloc();
    registerFallbackValue(FakeNowPlayingTvSeriesEvent());
    registerFallbackValue(FakeNowPlayingTvSeriesState());

    fakePopularTvSeriesBloc = FakePopularTvSeriesBloc();
    registerFallbackValue(FakePopularTvSeriesEvent());
    registerFallbackValue(FakePopularTvSeriesState());

    fakeTopRatedTvSeriesBloc = FakeTopRatedTvSeriesBloc();
    registerFallbackValue(FakeTopRatedTvSeriesEvent());
    registerFallbackValue(FakeTopRatedTvSeriesState());

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeNowPlayingTvSeriesBloc.close();
    fakePopularTvSeriesBloc.close();
    fakeTopRatedTvSeriesBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvSeriesBloc>(
          create: (context) => fakeNowPlayingTvSeriesBloc,
        ),
        BlocProvider<PopularTvSeriesBloc>(
          create: (context) => fakePopularTvSeriesBloc,
        ),
        BlocProvider<TopRatedTvSeriesBloc>(
          create: (context) => fakeTopRatedTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should display circular progress indicator when loading',
          (WidgetTester tester) async {
        when(() => fakeNowPlayingTvSeriesBloc.state)
            .thenReturn(NowPlayingTvSeriesLoading());
        when(() => fakePopularTvSeriesBloc.state)
            .thenReturn(PopularTvSeriesLoading());
        when(() => fakeTopRatedTvSeriesBloc.state)
            .thenReturn(TopRatedTvSeriesLoading());

        final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_createTestableWidget(const TvHomePage()));

        expect(circularProgressIndicatorFinder, findsNWidgets(3));
      });

  testWidgets(
      'Page should display listview of NowPlayingTvSeries when HasData state is happen',
          (WidgetTester tester) async {
        when(() => fakeNowPlayingTvSeriesBloc.state)
            .thenReturn(NowPlayingTvSeriesHasData(testTvList));
        when(() => fakePopularTvSeriesBloc.state)
            .thenReturn(PopularTvSeriesHasData(testTvList));
        when(() => fakeTopRatedTvSeriesBloc.state)
            .thenReturn(TopRatedTvSeriesHasData(testTvList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_createTestableWidget(const TvHomePage()));

        expect(listViewFinder, findsWidgets);
      });

  testWidgets('Page should display error with text when Error state is happen',
          (WidgetTester tester) async {
        when(() => fakeNowPlayingTvSeriesBloc.state)
            .thenReturn(NowPlayingTvSeriesError('error'));
        when(() => fakePopularTvSeriesBloc.state)
            .thenReturn(PopularTvSeriesError('error'));
        when(() => fakeTopRatedTvSeriesBloc.state)
            .thenReturn(TopRatedTvSeriesError('error'));

        final errorKeyFinder = find.byKey(const Key('error_msg'));

        await tester.pumpWidget(_createTestableWidget(const TvHomePage()));
        expect(errorKeyFinder, findsNWidgets(3));
      });

  testWidgets('Page should not display when Empty state is happen',
          (WidgetTester tester) async {
        when(() => fakeNowPlayingTvSeriesBloc.state)
            .thenReturn(NowPlayingTvSeriesEmpty());
        when(() => fakePopularTvSeriesBloc.state)
            .thenReturn(PopularTvSeriesEmpty());
        when(() => fakeTopRatedTvSeriesBloc.state)
            .thenReturn(TopRatedTvSeriesEmpty());

        final containerFinder = find.byType(Container);

        await tester.pumpWidget(_createTestableWidget(const TvHomePage()));
        expect(containerFinder, findsNWidgets(3));
      });
}
