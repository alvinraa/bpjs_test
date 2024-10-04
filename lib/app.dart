import 'package:bpjs_test/core/common/helper.dart';
import 'package:bpjs_test/core/common/navigation.dart';
import 'package:bpjs_test/core/common/routes.dart';
import 'package:bpjs_test/core/theme/style.dart';
import 'package:bpjs_test/feature/movie/bloc/movie_list/movie_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();

  static AppState of(BuildContext context) =>
      context.findAncestorStateOfType<AppState>()!;
}

class AppState extends State<App> {
  ThemeType themeType = ThemeType.light;

  @override
  Widget build(BuildContext context) {
    // layout potrait only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MovieListBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: Styles.appTheme(context, themeType),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: GestureDetector(
                onTap: () {
                  Helper.hideKeyboard(context);
                },
                child: child!),
          );
        },
        // routes: appRoutes,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
