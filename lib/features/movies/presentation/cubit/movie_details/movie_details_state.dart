import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieEntity movie;
  final ProfileCoverStatus profileCoverStatus;
  final String? profileCoverError;

  MovieDetailsLoaded({
    required this.movie,
    this.profileCoverStatus = ProfileCoverStatus.initial,
    this.profileCoverError,
  });
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}

enum ProfileCoverStatus { initial, loading, success, error }
