import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bpjs_test/feature/movie/data/model/movie_model.dart';
import 'package:bpjs_test/feature/movie/data/model/moviedb_response.dart';
import 'package:bpjs_test/feature/movie/data/repository/movie_repository.dart';
import 'package:meta/meta.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc() : super(GetMovieListLoading()) {
    on<GetMovieListRequest>((event, emit) async {
      await getMovieList(event, emit);
    });
  }

  MovieRepository repository = MovieRepository();
  MovieDBResponse response = MovieDBResponse();
  List<MovieModel> listMovie = [];

  int page = 1;

  FutureOr<void> getMovieList(
    GetMovieListRequest event,
    Emitter<MovieListState> emit,
  ) async {
    try {
      event.isLoadMore
          ? await _loadmoreMovies(event, emit)
          : await _getMoviesInit(event, emit);
    } catch (e) {
      emit(GetMovieListError(errorMessage: e.toString()));
    }
  }

  Future _getMoviesInit(
    GetMovieListRequest event,
    Emitter<MovieListState> emit,
  ) async {
    emit(GetMovieListLoading());
    page = 1;

    MovieDBResponse data = await repository.getPopularMovie(page);
    response = data;
    var list = data.results ?? [];
    listMovie = list;

    if (list.isNotEmpty) page += 1;
    emit(GetMovieListLoaded());
  }

  Future _loadmoreMovies(
    GetMovieListRequest event,
    Emitter<MovieListState> emit,
  ) async {
    emit(GetMovieListLoadMoreLoading());

    MovieDBResponse data = await repository.getPopularMovie(page);
    var list = data.results ?? [];

    if (list.isNotEmpty) {
      listMovie.addAll(list);
      page += 1;
    }
    emit(GetMovieListLoaded());
  }
}
