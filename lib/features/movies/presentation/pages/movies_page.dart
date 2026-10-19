import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movies_state.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movies/movies_hero_section.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movies/top_rated_section.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movies/trending_section.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MoviesError) {
            return Center(child: Text(state.message));
          }

          if (state is MoviesLoaded) {
            final trendingMovies = state.trendingMovies;
            final topRatedMovies = state.topRatedMovies;

            final randomIndex = Random().nextInt(trendingMovies.length);

            final randomMovie = trendingMovies[randomIndex];

            return SingleChildScrollView(
              child: Column(
                children: [
                  MoviesHeroSection(featuredMovie: randomMovie),
                  TrendingSection(trendingMovies: trendingMovies),
                  TopRatedSection(topRatedMovies: topRatedMovies),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
