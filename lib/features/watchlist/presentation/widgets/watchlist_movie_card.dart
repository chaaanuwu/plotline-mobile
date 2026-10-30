import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/widgets/movie_poster/movie_card.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_movie_entity.dart';

class WatchlistMovieCard extends StatelessWidget {
  final WatchlistMovieEntity movie;
  final VoidCallback? onTap;

  const WatchlistMovieCard({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MovieCard(
      posterPath: '${ImageConfig.tmdbPosterBaseUrl}${movie.posterPath}',
      title: movie.title,
      height: 180,
      width: 120,
      showTitle: true,
      onTap: onTap,
    );
  }
}
