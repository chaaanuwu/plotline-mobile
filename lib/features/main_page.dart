import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/common/widgets/bottom_navigation_bar/plotline_bottom_navbar.dart';
import 'package:plotline_mobile/features/home/presentation/pages/home_page.dart';
import 'package:plotline_mobile/features/movies/presentation/pages/movies_page.dart';
import 'package:plotline_mobile/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:plotline_mobile/features/profile/presentation/pages/profile_page.dart';
import 'package:plotline_mobile/features/search/presentation/pages/search_page.dart';
import 'package:plotline_mobile/service_locator.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();

    _profileCubit = sl<ProfileCubit>();
    _profileCubit.loadProfile();
  }

  @override
  void dispose() {
    _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const SearchPage(),
      const MoviesPage(),

      BlocProvider.value(value: _profileCubit, child: const ProfilePage()),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: KeyedSubtree(
          key: ValueKey(_currentIndex),
          child: pages[_currentIndex],
        ),
      ),
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
