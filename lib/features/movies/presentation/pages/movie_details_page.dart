import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';
import 'package:plotline_mobile/common/widgets/movie_poster/poster_card.dart';
import 'package:plotline_mobile/common/widgets/pill/pill.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/core/configs/theme/app_colors.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieEntity movie;

  const MovieDetailsPage({super.key, required this.movie});

  String _getReleaseYear(String dateStr) {
    if (dateStr.isEmpty) return 'N/A';
    return dateStr.split('-').first;
  }

  String _getReleaseStatus(String releaseDate) {
    if (releaseDate.isEmpty) return 'TBA';

    final date = DateTime.tryParse(releaseDate);
    if (date == null) return 'TBA';

    final today = DateTime.now();
    final releaseDay = DateTime(date.year, date.month, date.day);
    final currentDay = DateTime(today.year, today.month, today.day);

    return releaseDay.isAfter(currentDay) ? 'UPCOMING' : 'RELEASED';
  }

  @override
  Widget build(BuildContext context) {
    final textColor = context.isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = context.isDarkMode ? Colors.white70 : Colors.black87;

    final primaryColor = context.theme.colorScheme.primary;
    final secondaryColor = context.theme.colorScheme.secondary;

    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    final backdrop = movie.backdropPath;
    final poster = movie.posterPath;

    final backdropHeight = screenHeight * 0.42;
    final posterWidth = screenWidth * 0.42;
    final posterHeight = posterWidth * 1.5;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Backdrop
            SizedBox(
              width: double.infinity,
              height: backdropHeight,
              child: backdrop.isEmpty
                  ? Image.asset(AppImages.plotlineCover, fit: BoxFit.cover)
                  : Image.network(
                      '${ImageConfig.tmdbBackdropBaseUrl}$backdrop',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppImages.plotlineCover,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
            ),

            // Backdrop gradient
            Container(
              height: backdropHeight + 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.45, 1.0],
                  colors: [
                    Colors.transparent,
                    context.isDarkMode
                        ? AppColors.darkBackground.withValues(alpha: 0.75)
                        : AppColors.lightBackground.withValues(alpha: 0.75),
                    context.isDarkMode
                        ? AppColors.darkBackground
                        : AppColors.lightBackground,
                  ],
                ),
              ),
            ),

            // Back button
            Positioned(
              top: MediaQuery.paddingOf(context).top + 24,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  child: const Icon(
                    LucideIcons.arrowLeft,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),

            // Movie content
            Padding(
              padding: EdgeInsets.only(
                top: backdropHeight - posterHeight * 0.9,
                bottom: 32,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Movie poster
                      Center(
                        child: SizedBox(
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
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: movie.genres.map((genre) {
                          return Pill(
                            text: genre,
                            backgroundColor: secondaryColor.withValues(
                              alpha: 0.2,
                            ),
                            textColor: secondaryColor,
                            borderColor: secondaryColor.withValues(alpha: 0.75),
                            borderRadius: 50,
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 14),

                      // Release year, rating and language
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 0,
                        runSpacing: 8,
                        children: [
                          Text(
                            _getReleaseYear(movie.releaseDate),
                            style: TextStyle(
                              color: subtitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          if (movie.voteAverage > 0) ...[
                            _buildDot(subtitleColor),
                            Icon(
                              Icons.star_rounded,
                              color: primaryColor,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: TextStyle(
                                color: subtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],

                          if (movie.originalLanguage.isNotEmpty) ...[
                            _buildDot(subtitleColor),
                            Icon(
                              Icons.language_rounded,
                              color: subtitleColor,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie.originalLanguage.toUpperCase(),
                              style: TextStyle(
                                color: subtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],

                          SizedBox(width: 12),

                          // Details
                          GestureDetector(
                            child: Icon(
                              LucideIcons.info,
                              color: textColor,
                              size: 16,
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Release status
                      Text(
                        _getReleaseStatus(movie.releaseDate),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: BasicAppButton(
                              onPressed: () {},
                              height: 52,
                              backgroundColor: primaryColor,
                              textColor: Colors.white,
                              title: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(LucideIcons.circleCheckBig, size: 24),
                                  SizedBox(width: 8),
                                  Text(
                                    'Mark as Watched',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: BasicAppButton(
                              onPressed: () {},
                              height: 52,
                              backgroundColor: secondaryColor.withValues(
                                alpha: 0.15,
                              ),
                              textColor: secondaryColor,
                              borderColor: secondaryColor.withValues(
                                alpha: 0.4,
                              ),
                              title: const Icon(
                                LucideIcons.bookmark,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      BasicAppButton(
                        onPressed: () {},
                        height: 52,
                        backgroundColor: secondaryColor.withValues(alpha: 0.15),
                        textColor: secondaryColor,
                        borderColor: secondaryColor.withValues(alpha: 0.4),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.messagesSquare, size: 23),
                            const SizedBox(width: 8),
                            Text(
                              'Write a Review',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Overview section
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 3,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Overview',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            Text(
                              movie.overview.isNotEmpty
                                  ? movie.overview
                                  : 'No overview available for this movie yet.',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: subtitleColor,
                                fontSize: 14,
                                height: 1.7,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
