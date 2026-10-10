import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/common/widgets/appbar/app_bar.dart';
import 'package:plotline_mobile/common/widgets/logo/plotline_logo.dart';
import 'package:plotline_mobile/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:plotline_mobile/features/reviews/presentation/cubit/review_state.dart';
import 'package:plotline_mobile/features/reviews/presentation/widgets/review_card.dart';
import 'package:plotline_mobile/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: PlotlineLogo(), centerTitle: false),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => sl<ReviewCubit>()..getFeedReviews(),
          child: _buildReviews(),
        ),
      ),
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
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.reviews.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return const ReviewCard();
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
}
