import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
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

  static const _items = [
    (LucideIcons.house, 'Home'),
    (LucideIcons.search, 'Search'),
    (LucideIcons.clapperboard, 'Movies'),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final _activeColor = context.theme.colorScheme.primary;
    final barColor = isDark ? const Color(0xFF0A0A0A) : colorScheme.surface;

    final inactiveColor = colorScheme.onSurface.withValues(alpha: 0.52);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: barColor,
        border: Border(
          top: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.08)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              ...List.generate(_items.length, (index) {
                return Expanded(
                  child: _NavItem(
                    icon: _items[index].$1,
                    label: _items[index].$2,
                    isSelected: currentIndex == index,
                    activeColor: _activeColor,
                    inactiveColor: inactiveColor,
                    onTap: () => onItemSelected(index),
                  ),
                );
              }),

              Expanded(
                child: _ProfileNavItem(
                  avatarUrl: avatarUrl,
                  isSelected: currentIndex == 3,
                  activeColor: _activeColor,
                  inactiveColor: inactiveColor,
                  onTap: () => onItemSelected(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? activeColor : inactiveColor;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Active indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                width: isSelected ? 18 : 0,
                height: 3,
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: isSelected ? activeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Icon
              AnimatedScale(
                scale: isSelected ? 1.04 : 1.0,
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                child: Icon(icon, size: 23, color: color),
              ),

              const SizedBox(height: 4),

              // Label
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  letterSpacing: 0.1,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileNavItem extends StatelessWidget {
  final String? avatarUrl;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const _ProfileNavItem({
    required this.avatarUrl,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? activeColor : inactiveColor;

    final ImageProvider avatarImage = avatarUrl != null && avatarUrl!.isNotEmpty
        ? NetworkImage(avatarUrl!)
        : const AssetImage(AppImages.defaultpfp);

    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Profile',
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Active indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                width: isSelected ? 18 : 0,
                height: 3,
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: isSelected ? activeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Profile avatar
              AnimatedScale(
                scale: isSelected ? 1.04 : 1.0,
                duration: const Duration(milliseconds: 180),
                child: Container(
                  width: 25,
                  height: 25,
                  padding: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? activeColor
                          : inactiveColor.withValues(alpha: 0.55),
                      width: isSelected ? 1.6 : 1,
                    ),
                  ),
                  child: ClipOval(
                    child: Image(
                      image: avatarImage,
                      width: 22,
                      height: 22,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppImages.defaultpfp,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // Label
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  letterSpacing: 0.1,
                ),
                child: const Text('Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
