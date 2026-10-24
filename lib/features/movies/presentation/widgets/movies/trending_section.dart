import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/movie_poster/movie_card.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movie_details/movie_details_cubit.dart';
import 'package:plotline_mobile/features/movies/presentation/pages/movie_details_page.dart';

class TrendingSection extends StatelessWidget {
  final List<MovieEntity> trendingMovies;

  const TrendingSection({super.key, required this.trendingMovies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.local_fire_department_outlined,
                  color: context.theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  "Trending Now",
                  style: TextStyle(
                    color: context.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          if (trendingMovies.isNotEmpty) ...[
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: trendingMovies.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  child: MovieCard(
                    width: 130,
                    height: 195,
                    posterPath:
                        '${ImageConfig.tmdbPosterBaseUrl}${trendingMovies[index].posterPath}',
                    title: trendingMovies[index].title,
                    trendingRank: index + 1,
                    voteAverage: trendingMovies[index].voteAverage,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (context) =>
                                context.read<MovieDetailsCubit>()
                                  ..initialize(trendingMovies[index]),
                            child: MovieDetailsPage(
                              movie: trendingMovies[index],
                            ),
                          ),
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
