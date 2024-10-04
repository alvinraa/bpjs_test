import 'package:bpjs_test/core/common/assets.dart';
import 'package:bpjs_test/core/common/logger.dart';
import 'package:bpjs_test/core/widget/appbar/default_appbar.dart';
import 'package:bpjs_test/core/widget/shimmer/default_shimmer.dart';
import 'package:bpjs_test/feature/movie/presentation/widget/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MoviePage extends StatefulWidget {
  final dynamic data;
  const MoviePage({super.key, this.data});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // get data
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0 &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      Logger.print('LOADMORE');
      // load data again for pagination
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildContent(context),
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
    return RefreshIndicator(
      onRefresh: () async {
        // get data again
        Logger.print('REFRESH');
      },
      child: NotificationListener(
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
              itemCount: 5,
              itemBuilder: (context, index) {
                // var data = [];

                return MovieItem(
                  index: index,
                  // title: data.title ?? '-',
                  // desc: data.description ?? '-',
                  // date: data.createdDate,
                  // imageUrl: data.poster ?? '-',
                  // onTap: () {
                  //   // goes to detail page
                  // },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
