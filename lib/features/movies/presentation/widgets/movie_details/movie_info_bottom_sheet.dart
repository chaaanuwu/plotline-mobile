import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

class MovieInfoBottomSheet extends StatelessWidget {
  final MovieEntity movie;

  const MovieInfoBottomSheet({super.key, required this.movie});

  String _getReleaseStatus(String releaseDate) {
    if (releaseDate.isEmpty) return 'TBA';

    final date = DateTime.tryParse(releaseDate);
    if (date == null) return 'TBA';

    final today = DateTime.now();
    final releaseDay = DateTime(date.year, date.month, date.day);
    final currentDay = DateTime(today.year, today.month, today.day);

    return releaseDay.isAfter(currentDay) ? 'UPCOMING' : 'RELEASED';
  }

  String _formatReleaseDate(String releaseDate) {
    if (releaseDate.isEmpty) return 'TBA';

    final date = DateTime.tryParse(releaseDate);
    if (date == null) return 'TBA';

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color textColor,
    required Color mutedColor,
    required Color cardColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: mutedColor.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 17, color: mutedColor),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: mutedColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail({
    required String label,
    required String value,
    required TextStyle labelStyle,
    required TextStyle valueStyle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 5),
        Text(
          value.isEmpty ? 'Unknown' : value,
          style: valueStyle,
          softWrap: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = context.isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = context.isDarkMode ? Colors.white60 : Colors.black54;
    final cardColor = context.isDarkMode
        ? const Color(0xFF171717)
        : Colors.grey.shade100;

    final labelStyle = TextStyle(
      color: subtitleColor,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
    );

    final valueStyle = TextStyle(
      color: textColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    final releaseStatus = _getReleaseStatus(movie.releaseDate);
    final releaseLabel = releaseStatus == 'UPCOMING'
        ? 'EXPECTED PREMIERE'
        : 'PREMIERED';

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xFF0A0A0A) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: subtitleColor.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 22),

              Text(
                'Movie Details',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'More about this movie',
                style: TextStyle(color: subtitleColor, fontSize: 13),
              ),
              const SizedBox(height: 20),

              // Rating statistics
              Row(
                children: [
                  _buildStatCard(
                    icon: Icons.star_rounded,
                    label: 'VOTE AVERAGE',
                    value: movie.voteAverage.toStringAsFixed(1),
                    textColor: textColor,
                    mutedColor: subtitleColor,
                    cardColor: cardColor,
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    icon: Icons.people_outline_rounded,
                    label: 'VOTE COUNT',
                    value: movie.voteCount.toString(),
                    textColor: textColor,
                    mutedColor: subtitleColor,
                    cardColor: cardColor,
                  ),
                ],
              ),

              const SizedBox(height: 22),
              Divider(color: subtitleColor.withValues(alpha: 0.2)),
              const SizedBox(height: 20),

              // Movie metadata
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetail(
                          label: 'TITLE',
                          value: movie.title,
                          labelStyle: labelStyle,
                          valueStyle: valueStyle,
                        ),
                        const SizedBox(height: 20),
                        _buildDetail(
                          label: releaseLabel,
                          value: _formatReleaseDate(movie.releaseDate),
                          labelStyle: labelStyle,
                          valueStyle: valueStyle,
                        ),
                        const SizedBox(height: 20),
                        _buildDetail(
                          label: 'ORIGINAL LANGUAGE',
                          value: movie.originalLanguage.toUpperCase(),
                          labelStyle: labelStyle,
                          valueStyle: valueStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetail(
                          label: 'ORIGINAL TITLE',
                          value: movie.originalTitle,
                          labelStyle: labelStyle,
                          valueStyle: valueStyle,
                        ),
                        const SizedBox(height: 20),
                        _buildDetail(
                          label: 'ADULT CONTENT',
                          value: movie.adult ? 'Yes' : 'No',
                          labelStyle: labelStyle,
                          valueStyle: valueStyle,
                        ),
                        const SizedBox(height: 20),
                        Text('GENRES', style: labelStyle),
                        const SizedBox(height: 7),
                        if (movie.genres.isEmpty)
                          Text('Unknown', style: valueStyle)
                        else
                          ...movie.genres.map(
                            (genre) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(genre, style: valueStyle),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
