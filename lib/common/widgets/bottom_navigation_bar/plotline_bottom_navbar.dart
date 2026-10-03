import 'package:flutter/material.dart';

class PlotlineBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  const PlotlineBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  State<PlotlineBottomNavBar> createState() => _PlotlineBottomNavBarState();
}

class _PlotlineBottomNavBarState extends State<PlotlineBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                widget.currentIndex == 0 ? Icons.home : Icons.home_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                widget.currentIndex == 1 ? Icons.search : Icons.search_outlined,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                widget.currentIndex == 2 ? Icons.movie : Icons.movie_outlined,
              ),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                widget.currentIndex == 3 ? Icons.person : Icons.person_outlined,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: widget.currentIndex,
          onTap: widget.onItemSelected,
          iconSize: 28,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey[600],
          backgroundColor: Theme.of(context).colorScheme.surface,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          showSelectedLabels: true,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
