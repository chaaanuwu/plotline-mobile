import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/movie_poster/poster_card.dart';
import 'package:plotline_mobile/common/widgets/pill/pill.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

class MovieDetailsHeader extends StatelessWidget {
  final MovieEntity movie;
  final double posterWidth;
  final double posterHeight;

  const MovieDetailsHeader({
    super.key,
    required this.movie,
    required this.posterWidth,
    required this.posterHeight,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = context.isDarkMode ? Colors.white : Colors.black;
    final secondaryColor = context.theme.colorScheme.secondary;

    final poster = movie.posterPath;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Movie poster
        SizedBox(
          width: posterWidth,
          height: posterHeight,
          child: PosterCard(
            posterPath: poster.isEmpty
                ? AppImages.popcornCup
                : '${ImageConfig.tmdbPosterBaseUrl}$poster',
            height: posterHeight,
            spacing: 0,
          ),
        ),

        const SizedBox(height: 20),

        // Movie title
        Text(
          movie.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 28,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 12),

        // Genres
        if (movie.genres.isNotEmpty)
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: movie.genres.map((genre) {
              return Pill(
                text: genre,
                backgroundColor: secondaryColor.withValues(alpha: 0.2),
                textColor: secondaryColor,
                borderColor: secondaryColor.withValues(alpha: 0.75),
                borderRadius: 50,
              );
            }).toList(),
          ),
      ],
    );
  }
}
