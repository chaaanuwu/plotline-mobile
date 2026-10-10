class ReviewMovieEntity {
  final String movieId;
  final String title;
  final String backdropPath;
  final String posterPath;
  final List<String> genres;
  final String releaseDate;

  ReviewMovieEntity({
    required this.movieId,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.genres,
    required this.releaseDate,
  });
}
