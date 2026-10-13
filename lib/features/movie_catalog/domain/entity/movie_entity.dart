class MovieEntity {
  final String movieId;
  final String tmdbId;
  final String title;
  final String originalTitle;
  final bool adult;
  final List<String> genres;
  final String originalLanguage;
  final String overview;
  final String releaseDate;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final int voteCount;

  MovieEntity({
    required this.movieId,
    required this.tmdbId,
    required this.title,
    required this.originalTitle,
    required this.adult,
    required this.genres,
    required this.originalLanguage,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
  });
}
