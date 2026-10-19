import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/movie_poster/movie_card.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movies/presentation/pages/movie_details_page.dart';

class TopRatedSection extends StatelessWidget {
  final List<MovieEntity> topRatedMovies;

  const TopRatedSection({super.key, required this.topRatedMovies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Top-Rated",
              style: TextStyle(
                color: context.isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),

          const SizedBox(height: 12),

          if (topRatedMovies.isNotEmpty) ...[
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: topRatedMovies.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  child: MovieCard(
                    width: 130,
                    height: 195,
                    posterPath:
                        '${ImageConfig.tmdbPosterBaseUrl}${topRatedMovies[index].posterPath}',
                    title: topRatedMovies[index].title,
                    voteAverage: topRatedMovies[index].voteAverage,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              MovieDetailsPage(movie: topRatedMovies[index]),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
