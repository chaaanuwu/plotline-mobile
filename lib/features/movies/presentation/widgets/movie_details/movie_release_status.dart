import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

class MovieReleaseStatus extends StatelessWidget {
  final MovieEntity movie;

  const MovieReleaseStatus({super.key, required this.movie});

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
    return Text(
      _getReleaseStatus(movie.releaseDate),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: context.theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        letterSpacing: 1,
      ),
    );
  }
}
