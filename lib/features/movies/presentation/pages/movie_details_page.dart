import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movie_details/movie_details_cubit.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/community_reviews_section.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_backdrop.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_details_actions.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_details_header.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_metadata_row.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_overview_section.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_release_status.dart';
import 'package:plotline_mobile/service_locator.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieEntity movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    final backdropHeight = screenHeight * 0.42;
    final posterWidth = screenWidth * 0.42;
    final posterHeight = posterWidth * 1.5;

    return BlocProvider(
      create: (_) => sl<MovieDetailsCubit>()..initialize(movie),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  // Backdrop, gradient, and back button
                  MovieBackdrop(
                    movie: movie,
                    height: backdropHeight,
                    setAsProfileCover: () {
                      context.read<MovieDetailsCubit>().updateProfileCover();
                    },
                  ),

                  // Main movie content
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
                            // Poster, title, and genres
                            MovieDetailsHeader(
                              movie: movie,
                              posterWidth: posterWidth,
                              posterHeight: posterHeight,
                            ),

                            const SizedBox(height: 14),

                            // Year, rating, language, and details
                            MovieMetadataRow(movie: movie),

                            const SizedBox(height: 12),

                            // Release status
                            MovieReleaseStatus(movie: movie),

                            const SizedBox(height: 12),

                            // Watched, watchlist, and review actions
                            const MovieDetailsActions(),

                            const SizedBox(height: 32),

                            // Movie overview
                            MovieOverviewSection(movie: movie),

                            const SizedBox(height: 32),

                            // Community reviews
                            CommunityReviewsSection(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
