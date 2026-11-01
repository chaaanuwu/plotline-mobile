class WatchlistMovieEntity {
  final String movieId;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final List<String> genres;

  WatchlistMovieEntity({
    required this.movieId,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.genres,
  });
}
