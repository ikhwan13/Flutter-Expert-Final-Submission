import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_object_tv.dart';
import '../../helpers/page_test_helper.dart';

void main() {
  late FakeTvSeriesDetailBloc fakeTvSeriesDetailBloc;
  late FakeWatchlistTvSeriesBloc fakeWatchlistTvSeriesBloc;
  late FakeTvSeriesRecommendationBloc fakeTvSeriesRecommendationBloc;

  setUpAll(() {
    fakeTvSeriesDetailBloc = FakeTvSeriesDetailBloc();
    registerFallbackValue(FakeTvSeriesDetailEvent());
    registerFallbackValue(FakeTvSeriesDetailState());

    fakeWatchlistTvSeriesBloc = FakeWatchlistTvSeriesBloc();
    registerFallbackValue(FakeWatchlistTvSeriesEvent());
    registerFallbackValue(FakeWatchlistTvSeriesState());

    fakeTvSeriesRecommendationBloc = FakeTvSeriesRecommendationBloc();
    registerFallbackValue(FakeTvSeriesRecommendationEvent());
    registerFallbackValue(FakeTvSeriesRecommendationState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(
          create: (_) => fakeTvSeriesDetailBloc,
        ),
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (_) => fakeWatchlistTvSeriesBloc,
        ),
        BlocProvider<TvSeriesRecommendationBloc>(
          create: (_) => fakeTvSeriesRecommendationBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeTvSeriesDetailBloc.close();
    fakeWatchlistTvSeriesBloc.close();
    fakeTvSeriesRecommendationBloc.close();
  });

  const testId = 1;

  testWidgets('Page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailLoading());
    when(() => fakeWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesLoading());
    when(() => fakeTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('Should widget display which all required',
      (WidgetTester tester) async {
    when(() => fakeTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvDetail));
    when(() => fakeWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesHasData(testTvList));
    when(() => fakeTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvList));
    await tester
        .pumpWidget(_makeTestableWidget(const TvDetailPage(id: testId)));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('More Like This'), findsOneWidget);
    expect(find.byKey(const Key('detail_tv')), findsOneWidget);
  });

  testWidgets(
      'Should display add icon when Tvseries is not added to watchlist in watchlist button',
      (WidgetTester tester) async {
    when(() => fakeTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvDetail));
    when(() => fakeWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesIsAdded(false));
    when(() => fakeTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvList));
    final addIconFinder = find.byIcon(Icons.add);
    await tester
        .pumpWidget(_makeTestableWidget(const TvDetailPage(id: testId)));
    await tester.pump();
    expect(addIconFinder, findsOneWidget);
  });

  testWidgets(
      'Should display check icon when Tvseries is added to watchlist in watchlist button',
      (WidgetTester tester) async {
    when(() => fakeTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvDetail));
    when(() => fakeWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesIsAdded(true));
    when(() => fakeTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvList));
    final checkIconFinder = find.byIcon(Icons.check);
    await tester
        .pumpWidget(_makeTestableWidget(const TvDetailPage(id: testId)));
    await tester.pump();
    expect(checkIconFinder, findsOneWidget);
  });
}
