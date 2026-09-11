import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/widgets/movie_poster/poster_card.dart';

class MarqueeColumn extends StatelessWidget {
  final List<String> posters;
  final AnimationController controller;
  final int scrollDirection;

  const MarqueeColumn({
    super.key,
    required this.posters,
    required this.controller,
    required this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    const posterHeight = 198.0;
    const spacing = 12.0;
    const itemHeight = posterHeight + spacing;

    final totalHeight = posters.length * itemHeight;

    Widget posterSet() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: posters.map((posterPath) {
          return PosterCard(
            posterPath: posterPath,
            height: posterHeight,
            spacing: spacing,
          );
        }).toList(),
      );
    }

    return ClipRect(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final progress = controller.value;
          final offset = progress * totalHeight;

          if (scrollDirection == 1) {
            // Scroll upward
            return Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                Positioned(top: -offset, left: 0, right: 0, child: child!),
                Positioned(
                  top: totalHeight - offset,
                  left: 0,
                  right: 0,
                  child: child,
                ),
              ],
            );
          }

          // Scroll downward
          return Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -totalHeight + offset,
                left: 0,
                right: 0,
                child: child!,
              ),
              Positioned(top: offset, left: 0, right: 0, child: child),
            ],
          );
        },
        child: posterSet(),
      ),
    );
  }
}
