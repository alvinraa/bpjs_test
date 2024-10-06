import 'package:bpjs_test/core/common/logger.dart';
import 'package:bpjs_test/core/widget/shimmer/default_shimmer.dart';
import 'package:bpjs_test/feature/movie/presentation/widget/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // must initialize this if using DateTime, even already initialize in main.dart
  initializeDateFormatting();

  // Mock data for the test
  const String imageUrl =
      'https://image.tmdb.org/t/p/original/5ScPNT6fHtfYJeWBajZciPV3hEL.jpg';
  const String title = 'Movie Title';
  const String description = 'This is a short description of the movie.';
  const String rate = '8.5';
  const String popularity = '1234';
  const String language = 'EN';
  final DateTime date = DateTime.now();

  testWidgets('MovieItem widget displays movie details and reacts to tap',
      (WidgetTester tester) async {
    // Catch all exceptions and print them for diagnosis
    FlutterError.onError = (FlutterErrorDetails details) {
      Logger.print('Caught an error: ${details.exception}');
      FlutterError.presentError(details);
    };

    // Define a test key to identify the widget
    const movieItemKey = Key('movieItem');

    // Build the widget inside a MaterialApp to provide a proper context
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MovieItem(
            key: movieItemKey,
            index: 0,
            imageUrl: imageUrl,
            title: title,
            desc: description,
            date: date,
            rate: rate,
            popularity: popularity,
            language: language,
            isLoadmore: false,
            onTap: () {
              // This callback should be triggered on tap
              debugPrint('Movie Item Tapped');
            },
          ),
        ),
      ),
    );

    // Ensure the widget tree is built completely
    await tester.pumpAndSettle();

    // Check if the title is present
    expect(find.text('Movie Title'), findsOneWidget);

    // Check if the description is present
    expect(find.text(description), findsOneWidget);

    // Check if the popularity and rate are displayed correctly
    expect(find.text('1234'), findsOneWidget);
    expect(find.text('8.5/10'), findsOneWidget);

    // Tap on the widget to see if it triggers the onTap callback
    await tester.tap(find.byKey(movieItemKey));
    await tester.pump(); // Rebuild the widget to reflect the tap

    // Since the network image may not load in test environments, the `DefaultShimmer` might show up
    expect(find.byType(DefaultShimmer), findsNothing,
        reason:
            'The shimmer should not be visible when image loads successfully.');
  });
}
