import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:plotline_mobile/features/reviews/presentation/cubit/review_state.dart';
import 'package:plotline_mobile/features/reviews/presentation/widgets/review_card.dart';
import 'package:plotline_mobile/service_locator.dart';

class ProfileTabs extends StatefulWidget {
  const ProfileTabs({super.key});

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
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

        const SizedBox(height: 16),

        SizedBox(
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: [
              BlocProvider(
                create: (context) => sl<ReviewCubit>()..getMyReviews(),
                child: _buildReviews(),
              ),
              _buildWatchlist(),
              _buildHistory(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviews() {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ReviewLoaded) {
          if (state.reviews.isEmpty) {
            return const Center(child: Text('No reviews yet'));
          }

          return ListView.builder(
            itemCount: state.reviews.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              // final review = state.reviews[index];

              return ReviewCard();
            },
          );
        }

        if (state is ReviewError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildWatchlist() {
    return const Center(child: Text('Watchlist'));
  }

  Widget _buildHistory() {
    return const Center(child: Text('History'));
  }
}
