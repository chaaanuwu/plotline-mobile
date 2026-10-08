import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';

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
            children: [_buildReviews(), _buildWatchlist(), _buildHistory()],
          ),
        ),
      ],
    );
  }

  Widget _buildReviews() {
    return const Center(child: Text('Reviews'));
  }

  Widget _buildWatchlist() {
    return const Center(child: Text('Watchlist'));
  }

  Widget _buildHistory() {
    return const Center(child: Text('History'));
  }
}
