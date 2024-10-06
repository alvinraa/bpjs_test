import 'package:bpjs_test/core/common/constant.dart';
import 'package:bpjs_test/core/common/helper.dart';
import 'package:bpjs_test/core/common/logger.dart';
import 'package:bpjs_test/core/common/navigation.dart';
import 'package:bpjs_test/core/common/routes.dart';
import 'package:bpjs_test/core/utils/text_input_formatter.dart';
import 'package:bpjs_test/core/widget/appbar/default_appbar.dart';
import 'package:bpjs_test/core/widget/error/error_content.dart';
import 'package:bpjs_test/core/widget/indicator/loading_widget.dart';
import 'package:bpjs_test/core/widget/text_field/default_text_field.dart';
import 'package:bpjs_test/feature/movie/data/model/movie_model.dart';
import 'package:bpjs_test/feature/movie/presentation/widget/movie_item.dart';
import 'package:bpjs_test/feature/search/bloc/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  final dynamic data;
  const SearchPage({super.key, this.data});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<MovieModel> listSearchResult = [];
  final _scrollController = ScrollController();
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  String? searchValue;

  late SearchBloc searchBloc;

  @override
  void initState() {
    super.initState();
    // get data
    searchBloc = SearchBloc();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0 &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      Logger.print('LOADMORE');
      if (searchValue != "") {
        searchBloc.add(
            GetSearchRequest(isLoadMore: true, keyword: searchValue ?? ''));
      }
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

  DefaultAppBar buildAppBar(BuildContext context) {
    return DefaultAppBar(
      type: AppBarType.main,
      leading: Text(
        "Search",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 20),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: DefaultTextField(
            controller: searchController,
            focusNode: searchFocusNode,
            autofocus: true,
            inputFormatters: [
              NoLeadingSpacesInputFormatter(),
            ],
            hintStyle:
                textTheme.labelLarge?.copyWith(color: Colors.grey.shade500),
            suffixIcon: InkWell(
              onTap: () {
                if (searchValue != "" && searchValue != null) {
                  searchBloc.add(GetSearchRequest(keyword: searchValue ?? ''));
                  Helper.hideKeyboard(context);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                child: const Icon(
                  Icons.search,
                  size: 24,
                ),
              ),
            ),
            border: Colors.grey.shade300,
            borderRadius: 28,
            onChanged: (val) {
              // _debouncer.run(() {
              searchValue = val;
              //   setState(() {
              // initSearch = false;
              //     suggestionSearchBloc.keyword = searchValue ?? "";
              //     suggestionSearchBloc.add(const GetSuggestionSearch());
              //   });
              // });
            },
            onFieldSubmitted: (value) {
              if (value != "") {
                searchBloc.add(GetSearchRequest(keyword: value));
              }
              // hit api
            },
          ),
        ),
        const SizedBox(height: 8),
        // result
        BlocConsumer(
          bloc: searchBloc,
          listener: (context, state) {
            // do something if needed: implement listener.
          },
          builder: (context, state) {
            if (state is SearchInitial) {
              return Container();
            }

            if (state is SearchLoading) {
              return const LoadingWidget();
            }

            return buildSearchContent(context, state);
          },
        )
      ],
    );
  }

  Widget buildSearchContent(BuildContext context, Object? state) {
    listSearchResult = searchBloc.listMovie;

    if (listSearchResult.isEmpty) {
      return const Expanded(
        child: ErrorContent(
          showRefresh: false,
          type: ErrorType.empty,
        ),
      );
    }

    return Expanded(
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          return _handleScrollNotification(notification);
        },
        child: ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Movie Results',
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
              itemCount: searchBloc.listMovie.length,
              itemBuilder: (context, index) {
                MovieModel data = searchBloc.listMovie[index];

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
      ),
    );
  }
}
