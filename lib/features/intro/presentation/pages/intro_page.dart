import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/core/configs/assets/app_vectors.dart';
import 'package:plotline_mobile/core/configs/theme/app_colors.dart';
import 'package:plotline_mobile/features/intro/presentation/widgets/marquee_column.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late final AnimationController _controller1;
  late final AnimationController _controller2;
  late final AnimationController _controller3;

  final List<String> _column1 = const [
    AppPosters.poster1,
    AppPosters.poster2,
    AppPosters.poster3,
    AppPosters.poster4,
  ];

  final List<String> _column2 = const [
    AppPosters.poster5,
    AppPosters.poster6,
    AppPosters.poster7,
    AppPosters.poster8,
  ];

  final List<String> _column3 = const [
    AppPosters.poster9,
    AppPosters.poster10,
    AppPosters.poster11,
    AppPosters.poster12,
  ];

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 32),
    )..repeat();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          // Background poster marquee
          Positioned.fill(
            child: Opacity(
              opacity: 0.35,
              child: Row(
                children: [
                  Expanded(
                    child: MarqueeColumn(
                      posters: _column1,
                      controller: _controller1,
                      scrollDirection: 1,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: MarqueeColumn(
                      posters: _column2,
                      controller: _controller2,
                      scrollDirection: -1,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: MarqueeColumn(
                      posters: _column3,
                      controller: _controller3,
                      scrollDirection: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Dark overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.darkBackground.withValues(alpha: 0.1),
                    AppColors.darkBackground.withValues(alpha: 0.5),
                    AppColors.darkBackground.withValues(alpha: 0.98),
                    AppColors.darkBackground,
                  ],
                  stops: const [0.0, 0.4, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // Foreground content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 10),

                  // Accent pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightSecondary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.lightSecondary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Text(
                      'CINEMATIC SOCIAL NETWORK',
                      style: TextStyle(
                        color: AppColors.lightSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Logo
                  SvgPicture.asset(AppVectors.logoDark, width: 180, height: 60),

                  const SizedBox(height: 12),

                  // Tagline
                  Text(
                    'Discover. Review. Connect.',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.darkMainText,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Discover movies, track what you watch, and connect with fellow film lovers.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.darkSecondaryText,
                      fontWeight: FontWeight.w200,
                      letterSpacing: 0.2,
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Get Started button
                  BasicAppButton(
                    onPressed: () {},
                    title: "Get Started",
                    backgroundColor: context.theme.colorScheme.primary,
                    textColor: Colors.black,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
