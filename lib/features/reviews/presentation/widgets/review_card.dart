import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:plotline_mobile/features/reviews/presentation/cubit/review_state.dart';
import 'package:plotline_mobile/features/reviews/presentation/widgets/review_item.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReviewCubit>().state;

    if (state is ReviewInitial || state is ReviewLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is ReviewError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(state.message, textAlign: TextAlign.center),
        ),
      );
    }

    if (state is! ReviewLoaded) {
      return const SizedBox.shrink();
    }

    final reviews = state.reviews;

    if (reviews.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('No reviews yet.'),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: reviews.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        return ReviewItem(reviewData: reviews[index]);
      },
    );
  }
}
