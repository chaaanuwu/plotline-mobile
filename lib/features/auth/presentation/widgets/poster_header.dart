import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/widgets/movie_poster/poster_card.dart';

class PosterHeader extends StatelessWidget {
  final List<String> posters;

  const PosterHeader({super.key, required this.posters});

  @override
  Widget build(BuildContext context) {
    final rotations = [-0.08, -0.025, 0.025, 0.08];

    return SizedBox(
      height: 155,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(posters.length, (index) {
          return Transform.rotate(
            angle: rotations[index],
            child: Container(
              width: 76,
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: PosterCard(
                height: 120,
                posterPath: posters[index],
                spacing: 0,
              ),
            ),
          );
        }),
      ),
    );
  }
}
