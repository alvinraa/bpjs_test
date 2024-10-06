import 'package:bpjs_test/core/common/assets.dart';
import 'package:bpjs_test/core/common/constant.dart';
import 'package:bpjs_test/core/common/logger.dart';
import 'package:bpjs_test/core/common/navigation.dart';
import 'package:bpjs_test/core/common/routes.dart';
import 'package:bpjs_test/core/widget/appbar/default_appbar.dart';
import 'package:bpjs_test/core/widget/shimmer/default_shimmer.dart';
import 'package:bpjs_test/feature/movie/bloc/movie_list/movie_list_bloc.dart';
import 'package:bpjs_test/feature/movie/data/model/movie_model.dart';
import 'package:bpjs_test/feature/movie/presentation/widget/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePage extends StatefulWidget {
  final dynamic data;
  const MoviePage({super.key, this.data});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _scrollController = ScrollController();
  late MovieListBloc movieListBloc;

  @override
  void initState() {
    super.initState();
    // get data
    movieListBloc = MovieListBloc();
    movieListBloc.add(GetMovieListRequest());
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0 &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      Logger.print('LOADMORE');
      movieListBloc.add(GetMovieListRequest(isLoadMore: true));
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async {
          // get data again
          Logger.print('REFRESH');
          movieListBloc.add(GetMovieListRequest());
        },
        child: buildContent(context),
      ),
    );
  }

  buildAppBar(BuildContext context) {
    return DefaultAppBar(
      type: AppBarType.main,
      leading: Text(
        "Netflix",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 20),
      ),
      actions: [
        // search
        GestureDetector(
          onTap: () {
            // goes to search page
            Logger.print('SEARCH');
            navigatorKey.currentState?.pushNamed(
              Routes.searchPage,
            );
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 14, 0),
            child: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.secondary,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  buildContent(BuildContext context) {
    return BlocConsumer(
      bloc: movieListBloc,
      listener: (context, state) {
        // if needed only.
      },
      builder: (context, state) {
        if (state is GetMovieListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetMovieListError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text(state.errorMessage ?? "-")),
          );
        }

        return buildMovieList(context, state);
      },
    );
  }

  Widget buildMovieList(BuildContext context, Object? state) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        return _handleScrollNotification(notification);
      },
      child: ListView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Image.network(
            height: 200,
            'https://image.tmdb.org/t/p/original/5ScPNT6fHtfYJeWBajZciPV3hEL.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const DefaultShimmer(
                  height: 200,
                );
              }
            },
            errorBuilder: (context, url, error) => Image.asset(
              Assets.placeholderWide,
              fit: BoxFit.fill,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Popular Movies',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => Container(
              margin: const EdgeInsets.only(
                bottom: 8,
                top: 8,
              ),
              child: const Divider(thickness: 4),
            ),
            itemCount: movieListBloc.listMovie.length,
            itemBuilder: (context, index) {
              MovieModel data = movieListBloc.listMovie[index];

              return MovieItem(
                index: index,
                title: data.title ?? '-',
                desc: data.overview ?? '-',
                date: data.releaseDate,
                imageUrl: '${Constant.baseImageUrl}${data.posterPath}',
                rate: data.voteAverage?.toStringAsFixed(1) ?? '-',
                popularity: data.popularity?.toStringAsFixed(0) ?? '-',
                language: data.originalLanguage?.toUpperCase() ?? '-',
                onTap: () {
                  // goes to detail page
                  Logger.print('ontap');
                  navigatorKey.currentState?.pushNamed(
                    Routes.movieDetailPage,
                    arguments: data,
                  );
                },
              );
            },
          ),
          // show for loadmore
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
