import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

class MovieOverviewSection extends StatelessWidget {
  final MovieEntity movie;

  const MovieOverviewSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textColor = context.isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = context.isDarkMode ? Colors.white70 : Colors.black87;

    return SizedBox(
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
                  color: context.theme.colorScheme.primary,
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
    );
  }
}
