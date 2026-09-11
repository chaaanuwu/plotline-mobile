import 'package:flutter/material.dart';

class PosterCard extends StatelessWidget {
  final String posterPath;
  final double height;
  final double spacing;

  const PosterCard({
    super.key,
    required this.posterPath,
    required this.height,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: spacing),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: Image.asset(
            posterPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[900],
                child: Center(
                  child: Icon(
                    Icons.movie_rounded,
                    color: Colors.grey[800],
                    size: 32,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
