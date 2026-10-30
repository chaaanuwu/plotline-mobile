import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';

import 'package:plotline_mobile/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:plotline_mobile/features/reviews/presentation/cubit/review_state.dart';
import 'package:plotline_mobile/features/reviews/presentation/widgets/review_card.dart';

import 'package:plotline_mobile/features/watchlist/presentation/cubit/watchlist_cubit.dart';
import 'package:plotline_mobile/features/watchlist/presentation/cubit/watchlist_state.dart';
import 'package:plotline_mobile/features/watchlist/presentation/widgets/watchlist_tab.dart';

import 'package:plotline_mobile/service_locator.dart';

class ProfileTabs extends StatefulWidget {
  final ScrollController scrollController;

  const ProfileTabs({super.key, required this.scrollController});

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late ReviewCubit _reviewCubit;
  late WatchlistCubit _watchlistCubit;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    _reviewCubit = sl<ReviewCubit>()..getMyReviews();

    _watchlistCubit = sl<WatchlistCubit>()..getWatchlist(null);

    _tabController.addListener(_onTabChanged);

    widget.scrollController.addListener(_onScroll);
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  void _onScroll() {
    if (_tabController.index != 1) return;

    if (!widget.scrollController.hasClients) return;

    final position = widget.scrollController.position;

    if (position.extentAfter < 400) {
      final state = _watchlistCubit.state;

      if (state is WatchlistLoaded && !state.isLoadingMore) {
        _watchlistCubit.loadMore(null);
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);

    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();

    _reviewCubit.close();
    _watchlistCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _buildTabBar(),
          ),
        ),
        if (_tabController.index == 0)
          _buildReviews()
        else if (_tabController.index == 1)
          _buildWatchlist()
        else
          _buildHistory(),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.06),
          ),
        ),
        child: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: context.theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: context.theme.colorScheme.primary.withValues(
                  alpha: 0.25,
                ),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          labelColor: Colors.white,
          unselectedLabelColor: context.isDarkMode
              ? Colors.white60
              : Colors.black54,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          labelPadding: EdgeInsets.zero,
          tabs: const [
            Tab(height: 42, text: 'Reviews'),
            Tab(height: 42, text: 'Watchlist'),
            Tab(height: 42, text: 'History'),
          ],
        ),
      ),
    );
  }

  // REVIEWS
  Widget _buildReviews() {
    return BlocProvider.value(
      value: _reviewCubit,
      child: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          if (state is ReviewLoading) {
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is ReviewLoaded) {
            if (state.reviews.isEmpty) {
              return const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text('No reviews yet')),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              sliver: SliverList.builder(
                itemCount: state.reviews.length,
                itemBuilder: (context, index) {
                  return const ReviewCard();
                },
              ),
            );
          }

          if (state is ReviewError) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text(state.message)),
            );
          }

          return const SliverToBoxAdapter(child: SizedBox.shrink());
        },
      ),
    );
  }

  // WATCHLIST
  Widget _buildWatchlist() {
    return BlocProvider.value(
      value: _watchlistCubit,
      child: const WatchlistTab(),
    );
  }

  // HISTORY
  Widget _buildHistory() {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: Text('History')),
    );
  }
}
