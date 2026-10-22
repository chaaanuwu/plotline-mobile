import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_info_bottom_sheet.dart';

class MovieMetadataRow extends StatelessWidget {
  final MovieEntity movie;

  const MovieMetadataRow({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final subtitleColor = context.isDarkMode ? Colors.white70 : Colors.black87;
    final primaryColor = context.theme.colorScheme.primary;

    final year = movie.releaseDate.isEmpty
        ? 'N/A'
        : movie.releaseDate.split('-').first;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 0,
      runSpacing: 8,
      children: [
        Text(
          year,
          style: TextStyle(
            color: subtitleColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        if (movie.voteAverage > 0) ...[
          _buildDot(subtitleColor),
          Icon(Icons.star_rounded, color: primaryColor, size: 18),
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
          Icon(LucideIcons.globe, color: subtitleColor, size: 16),
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

        const SizedBox(width: 12),

        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return MovieInfoBottomSheet(movie: movie);
              },
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Icon(LucideIcons.info, color: subtitleColor, size: 16),
          ),
        ),
      ],
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
