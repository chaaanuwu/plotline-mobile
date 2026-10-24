import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/movie_poster/poster_card.dart';
import 'package:plotline_mobile/common/widgets/pill/pill.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movies/presentation/pages/movie_details_page.dart';

class MoviesHeroSection extends StatelessWidget {
  final MovieEntity featuredMovie;

  const MoviesHeroSection({super.key, required this.featuredMovie});

  String _getReleaseYear(String dateStr) {
    if (dateStr.isEmpty) return 'N/A';
    return dateStr.split('-').first;
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = context.theme.scaffoldBackgroundColor;
    final primaryColor = context.theme.colorScheme.primary;
    final textColor = context.isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = context.isDarkMode ? Colors.white70 : Colors.black87;

    final screenHeight = MediaQuery.sizeOf(context).height;

    final heroHeight = screenHeight * 0.4;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: double.infinity,
          height: heroHeight,
          child: featuredMovie.backdropPath.isNotEmpty
              ? PosterCard(
                  posterPath:
                      '${ImageConfig.tmdbBackdropBaseUrl}${featuredMovie.backdropPath}',
                  height: heroHeight,
                  spacing: 0,
                )
              : PosterCard(
                  posterPath: AppImages.popcornCup,
                  height: heroHeight,
                  spacing: 0,
                ),
        ),

        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  bgColor.withValues(alpha: 0),
                  bgColor.withValues(alpha: 0.65),
                  bgColor.withValues(alpha: 1.0),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Pill(
                text: 'TRENDING',
                preIcon: Icons.local_fire_department_outlined,
                iconColor: primaryColor,
                backgroundColor: primaryColor.withValues(alpha: 0.2),
                textColor: primaryColor,
                borderColor: primaryColor.withValues(alpha: 0.75),
                borderRadius: 50,
              ),

              const SizedBox(height: 8),

              // Title
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailsPage(
                        movie: featuredMovie,
                      ),
                    ),
                  );
                },
                child: Text(
                  featuredMovie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  // Release Year
                  Text(
                    _getReleaseYear(featuredMovie.releaseDate),
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // Vote Average
                  if (featuredMovie.voteAverage > 0) ...[
                    _buildDot(subtitleColor),
                    Icon(Icons.star_rounded, color: primaryColor, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      featuredMovie.voteAverage.toStringAsFixed(1),
                      style: TextStyle(
                        color: subtitleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],

                  // Language
                  if (featuredMovie.originalLanguage.isNotEmpty) ...[
                    _buildDot(subtitleColor),
                    Icon(
                      Icons.language_rounded,
                      color: subtitleColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      featuredMovie.originalLanguage.toUpperCase(),
                      style: TextStyle(
                        color: subtitleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDot(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        '•',
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
