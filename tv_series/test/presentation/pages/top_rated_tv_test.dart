import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/page_test_helper.dart';

void main() {
  late FakeTopRatedTvSeriesBloc fakeTopRatedTvSeriesBloc;

  setUpAll(() {
    fakeTopRatedTvSeriesBloc = FakeTopRatedTvSeriesBloc();
    registerFallbackValue(FakeTopRatedTvSeriesEvent());
    registerFallbackValue(FakeTopRatedTvSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>(
      create: (_) => fakeTopRatedTvSeriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() => fakeTopRatedTvSeriesBloc.close());

  testWidgets('page should display circular progress indicator when loading',
          (WidgetTester tester) async {
        when(() => fakeTopRatedTvSeriesBloc.state)
            .thenReturn(TopRatedTvSeriesLoading());

        final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));
        await tester.pump();

        expect(circularProgressIndicatorFinder, findsOneWidget);
      });

  testWidgets('should display text with message when error',
          (WidgetTester tester) async {
        const errorMessage = 'error message';

        when(() => fakeTopRatedTvSeriesBloc.state)
            .thenReturn(TopRatedTvSeriesError(errorMessage));

        final textMessageKeyFinder = find.byKey(const Key('error_msg'));
        await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));
        await tester.pump();

        expect(textMessageKeyFinder, findsOneWidget);
      });
}
