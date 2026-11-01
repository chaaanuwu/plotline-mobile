import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final String query;
  final List<MovieEntity> movies;

  SearchLoaded({required this.query, required this.movies});
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
