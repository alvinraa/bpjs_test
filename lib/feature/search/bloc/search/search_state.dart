part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchMoreLoading extends SearchState {}

final class SearchSuccess extends SearchState {}

final class SearchError extends SearchState {
  final String? errorMessage;

  SearchError({
    this.errorMessage,
  });
}
