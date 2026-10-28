import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/movie_poster/movie_card.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/movies/presentation/pages/movie_details_page.dart';
import 'package:plotline_mobile/features/search/presentation/cubit/search_cubit.dart';
import 'package:plotline_mobile/features/search/presentation/cubit/search_state.dart';
import 'package:plotline_mobile/features/search/presentation/widgets/search_message.dart';
import 'package:plotline_mobile/service_locator.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor = isDark ? Colors.white : const Color(0xFF18181B);
    final secondaryColor = isDark ? Colors.white60 : Colors.black54;

    return BlocProvider(
      create: (_) => sl<SearchCubit>()..getSearchResults(widget.query),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(LucideIcons.arrowLeft, color: textColor, size: 22),
          ),
          titleSpacing: 0,
          title: Text(
            'Search results',
            style: TextStyle(
              color: textColor,
              fontSize: 19,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  strokeWidth: 2.5,
                ),
              );
            }

            if (state is SearchError) {
              return SearchMessage(
                icon: LucideIcons.circleAlert,
                title: 'Something went wrong',
                subtitle: state.message,
                textColor: textColor,
                secondaryColor: secondaryColor,
              );
            }

            if (state is SearchLoaded) {
              if (state.movies.isEmpty) {
                return SearchMessage(
                  icon: LucideIcons.film,
                  title: 'No movies found',
                  subtitle:
                      'We couldn’t find anything matching '
                      '"${widget.query}". Try another title.',
                  textColor: textColor,
                  secondaryColor: secondaryColor,
                );
              }

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Search heading
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 14, 22, 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DISCOVER',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 9),
                          Text(
                            'Results for "${widget.query}"',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.7,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${state.movies.length} '
                            '${state.movies.length == 1 ? 'movie' : 'movies'} found',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Movie grid
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final movie = state.movies[index];
                        return Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: 160,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Movie
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            MovieDetailsPage(movie: movie),
                                      ),
                                    );
                                  },
                                  // Poster
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 230,
                                      child: MovieCard(
                                        posterPath: movie.posterPath.isNotEmpty
                                            ? '${ImageConfig.tmdbPosterBaseUrl}${movie.posterPath}'
                                            : '',
                                        height: 230,
                                        title: movie.title,
                                        spacing: 0,
                                        showTitle: false,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Movie title
                                Text(
                                  movie.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3,
                                    letterSpacing: -0.2,
                                  ),
                                ),

                                const SizedBox(height: 7),

                                // Rating and release year
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: primaryColor,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      movie.voteAverage.toStringAsFixed(1),
                                      style: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      movie.releaseDate.isNotEmpty
                                          ? movie.releaseDate.split('-').first
                                          : 'Unknown year',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 11.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }, childCount: state.movies.length),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 24,
                            mainAxisExtent: 315,
                          ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
