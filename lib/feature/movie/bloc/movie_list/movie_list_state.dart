part of 'movie_list_bloc.dart';

@immutable
sealed class MovieListState {}

class GetMovieListLoading extends MovieListState {}

class GetMovieListLoadMoreLoading extends MovieListState {}

class GetMovieListLoaded extends MovieListState {
  GetMovieListLoaded();
}

class GetMovieListError extends MovieListState {
  final String? errorMessage;
  GetMovieListError({this.errorMessage});
}
