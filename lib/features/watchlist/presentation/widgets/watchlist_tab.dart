import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:plotline_mobile/features/movies/presentation/pages/movie_details_page.dart';
import 'package:plotline_mobile/features/watchlist/presentation/cubit/watchlist_cubit.dart';
import 'package:plotline_mobile/features/watchlist/presentation/cubit/watchlist_state.dart';
import 'package:plotline_mobile/features/watchlist/presentation/widgets/watchlist_movie_card.dart';

class WatchlistTab extends StatelessWidget {
  const WatchlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocBuilder<WatchlistCubit, WatchlistState>(
      builder: (context, state) {
        // Initial loading
        if (state is WatchlistLoading || state is WatchlistInitial) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: CircularProgressIndicator(
                color: colors.primary,
                strokeWidth: 2.5,
              ),
            ),
          );
        }

        // Error
        if (state is WatchlistError) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: _buildError(context, state.message),
          );
        }

        // Loaded
        if (state is WatchlistLoaded) {
          if (state.watchlist.isEmpty) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: _buildEmptyState(context),
            );
          }

          return SliverMainAxisGroup(
            slivers: [
              // Watchlist heading
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 14),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Text(
                        'Watchlist',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${state.watchlist.length}',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.53,
                  ),
                  itemCount:
                      state.watchlist.length + (state.isLoadingMore ? 3 : 0),
                  itemBuilder: (context, index) {
                    // Pagination indicators
                    if (index >= state.watchlist.length) {
                      return Center(
                        child: SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colors.primary,
                          ),
                        ),
                      );
                    }

                    final item = state.watchlist[index];

                    return WatchlistMovieCard(
                      key: ValueKey(item.id),
                      movie: item.movie,
                      onTap: () {
                        final movieId = state.watchlist[index].movie.movieId;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MovieDetailsPage(movieId: movieId),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  // Empty state
  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: colors.primary.withValues(alpha: 0.18),
                ),
              ),
              child: Icon(
                LucideIcons.bookmark,
                size: 34,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Your watchlist is waiting',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Keep track of the movies you want to watch next. '
              'They’ll all be waiting for you here.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Error state
  Widget _buildError(BuildContext context, String message) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.cloudAlert, size: 36, color: colors.error),
            const SizedBox(height: 12),
            Text(
              'Couldn’t load your watchlist',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                context.read<WatchlistCubit>().getWatchlist(null);
              },
              icon: const Icon(LucideIcons.refreshCw, size: 16),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
