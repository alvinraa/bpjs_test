part of 'movie_list_bloc.dart';

@immutable
sealed class MovieListEvent {}

class GetMovieListRequest extends MovieListEvent {
  final bool isLoadMore;
  GetMovieListRequest({this.isLoadMore = false});
}
