import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movie_details/movie_details_cubit.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movie_details/movie_details_state.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/community_reviews_section.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_backdrop.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_details_actions.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_details_header.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_metadata_row.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_overview_section.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/movie_release_status.dart';
import 'package:plotline_mobile/service_locator.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieEntity? movie;
  final String? movieId;

  const MovieDetailsPage({super.key, this.movie, this.movieId})
    : assert(
        movie != null || movieId != null,
        'Either movie or movieId must be provided.',
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = sl<MovieDetailsCubit>();

        if (movie != null) {
          cubit.initialize(movie!);
        } else {
          cubit.loadMovieById(movieId!);
        }

        return cubit;
      },
      child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoaded) {
            return _buildMovieDetails(context, state.movie);
          }

          if (state is MovieDetailsError) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 12),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<MovieDetailsCubit>().loadMovieById(
                          movieId!,
                        );
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildMovieDetails(BuildContext context, MovieEntity movie) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    final backdropHeight = screenHeight * 0.42;
    final posterWidth = screenWidth * 0.42;
    final posterHeight = posterWidth * 1.5;

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
  }
}
