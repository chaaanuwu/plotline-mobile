import 'package:flutter/material.dart';
import 'package:plotline_mobile/features/reviews/domain/entity/review_entity.dart';
import 'package:plotline_mobile/features/reviews/presentation/widgets/review_item.dart';

class ReviewCard extends StatelessWidget {
  // CHANGED: Each ReviewCard receives one review.
  final ReviewEntity review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ReviewItem(reviewData: review),
    );
  }
}
