import 'package:flutter/material.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';

class PlotlineBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final String? avatarUrl;
  final Function(int) onItemSelected;

  const PlotlineBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.avatarUrl,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final items = [
      (Icons.home_outlined, Icons.home, 'Home'),
      (Icons.search_outlined, Icons.search, 'Search'),
      (Icons.movie_outlined, Icons.movie, 'Movies'),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      height: 70,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List.generate(
              items.length,
              (index) {
                final isSelected = currentIndex == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => onItemSelected(index),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary.withValues(alpha: 0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: Icon(
                              isSelected ? items[index].$2 : items[index].$1,
                              key: ValueKey(isSelected),
                              size: 25,
                              color: isSelected
                                  ? colorScheme.primary
                                  : colorScheme.onSurface.withValues(
                                      alpha: 0.55,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 3),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? colorScheme.primary
                                  : colorScheme.onSurface.withValues(
                                      alpha: 0.55,
                                    ),
                            ),
                            child: Text(items[index].$3),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            Expanded(
              child: GestureDetector(
                onTap: () => onItemSelected(3),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: currentIndex == 3
                        ? colorScheme.primary.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedScale(
                        scale: currentIndex == 3 ? 1.08 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          width: 27,
                          height: 27,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: currentIndex == 3
                                ? Border.all(
                                    color: colorScheme.primary,
                                    width: 2,
                                  )
                                : null,
                          ),
                          child: CircleAvatar(
                            radius: 13.5,
                            backgroundImage:
                                avatarUrl == null || avatarUrl!.isEmpty
                                    ? const AssetImage(AppImages.defaultpfp)
                                    : NetworkImage(avatarUrl!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: currentIndex == 3
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: currentIndex == 3
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(
                                  alpha: 0.55,
                                ),
                        ),
                        child: const Text('Profile'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}