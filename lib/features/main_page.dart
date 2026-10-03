import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/widgets/bottom_navigation_bar/plotline_bottom_navbar.dart';
import 'package:plotline_mobile/features/home/presentation/pages/home_page.dart';
import 'package:plotline_mobile/features/movies/presentation/pages/movies_page.dart';
import 'package:plotline_mobile/features/profile/presentation/pages/profile_page.dart';
import 'package:plotline_mobile/features/search/presentation/pages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const MoviesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: PlotlineBottomNavBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
