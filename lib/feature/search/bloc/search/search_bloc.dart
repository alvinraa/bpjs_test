import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bpjs_test/feature/movie/data/model/movie_model.dart';
import 'package:bpjs_test/feature/movie/data/model/moviedb_response.dart';
import 'package:bpjs_test/feature/search/data/repository/search_repository.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<GetSearchRequest>((event, emit) async {
      await getSearch(event, emit);
    });
  }

  SearchRepository repository = SearchRepository();
  MovieDBResponse response = MovieDBResponse();
  List<MovieModel> listMovie = [];

  int page = 1;

  FutureOr<void> getSearch(
    GetSearchRequest event,
    Emitter<SearchState> emit,
  ) async {
    try {
      event.isLoadMore
          ? await _loadmoreSearch(event, emit)
          : await _getSearchInit(event, emit);
    } catch (e) {
      emit(SearchError(errorMessage: e.toString()));
    }
  }

  Future _getSearchInit(
    GetSearchRequest event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    page = 1;

    MovieDBResponse data = await repository.searchMovie(
      keyword: event.keyword,
      page: page,
    );
    response = data;
    var list = data.results ?? [];
    listMovie = list;

    if (list.isNotEmpty) page += 1;
    emit(SearchSuccess());
  }

  Future _loadmoreSearch(
    GetSearchRequest event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchMoreLoading());

    MovieDBResponse data = await repository.searchMovie(
      keyword: event.keyword,
      page: page,
    );
    var list = data.results ?? [];

    if (list.isNotEmpty) {
      listMovie.addAll(list);
      page += 1;
    }
    emit(SearchSuccess());
  }
}
