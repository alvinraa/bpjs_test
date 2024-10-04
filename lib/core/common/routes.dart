import 'package:bpjs_test/feature/movie/presentation/page/movie_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String moviePage = '/';
}

// Map<String, Widget Function(BuildContext)> appRoutes = {
//   Routes.moviePage: (context) => const MoviePage(),
// };

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.moviePage:
      return MaterialPageRoute(
        builder: (BuildContext context) => MoviePage(
          data: settings.arguments,
        ),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (BuildContext context) => const Scaffold(
          body: Center(
            child: Text('Route not defined'),
          ),
        ),
        settings: settings,
      );
  }
}
