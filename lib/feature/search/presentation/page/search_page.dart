import 'package:bpjs_test/core/common/logger.dart';
import 'package:bpjs_test/core/utils/text_input_formatter.dart';
import 'package:bpjs_test/core/widget/appbar/default_appbar.dart';
import 'package:bpjs_test/core/widget/text_field/default_text_field.dart';
import 'package:bpjs_test/feature/movie/data/model/movie_model.dart';
import 'package:bpjs_test/feature/movie/presentation/widget/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
                  // searchBloc
                  //     .add(GetSearchRequest(keyword: searchValue ?? ''));
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
                // searchBloc.add(GetSearchRequest(keyword: value));
              }
              // hit api
            },
          ),
        ),
        // result
        Expanded(
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
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    // MovieModel data = movieListBloc.listMovie[index];
                    // var data = [];

                    return MovieItem(
                      index: index,
                      title: '-',
                      desc: '-',
                      date: DateTime.now(),
                      imageUrl: '-',
                      rate: '-',
                      popularity: '-',
                      language: '-',
                      onTap: () {},
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
