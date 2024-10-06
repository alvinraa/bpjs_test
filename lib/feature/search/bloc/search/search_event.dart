part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class GetSearchRequest extends SearchEvent {
  final bool isLoadMore;
  final String keyword;

  GetSearchRequest({
    required this.keyword,
    this.isLoadMore = false,
  });
}
