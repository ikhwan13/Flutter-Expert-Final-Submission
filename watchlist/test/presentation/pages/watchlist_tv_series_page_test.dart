import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/watchlist.dart';

import '../../helpers/page_test_helper.dart';

void main() {
  late FakeWatchlistTvSeriesBloc fakeWatchlistTvSeriesBloc;

  setUpAll(() {
    fakeWatchlistTvSeriesBloc = FakeWatchlistTvSeriesBloc();
    registerFallbackValue(FakeWatchlistMovieEvent());
    registerFallbackValue(FakeWatchlistMovieState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvSeriesBloc>(
      create: (_) => fakeWatchlistTvSeriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() => fakeWatchlistTvSeriesBloc.close());

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvSeriesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakeWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_msg'));
    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvSeriesPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
