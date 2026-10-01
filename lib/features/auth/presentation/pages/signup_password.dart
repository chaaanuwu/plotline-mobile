import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/appbar/app_bar.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';
import 'package:plotline_mobile/common/widgets/logo/plotline_logo.dart';
import 'package:plotline_mobile/common/widgets/text_field/basic_text_field.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/features/auth/data/models/signup_data.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/auth_header.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/poster_header.dart';

class SignupPasswordPage extends StatefulWidget {
  final SignupData signupData;

  const SignupPasswordPage({super.key, required this.signupData});

  @override
  State<SignupPasswordPage> createState() => _SignupPasswordPageState();
}

class _SignupPasswordPageState extends State<SignupPasswordPage> {
  bool _obscurePassword = true;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: PlotlineLogo()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 24, 30, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PosterHeader(
              posters: [
                AppImages.poster9,
                AppImages.poster10,
                AppImages.poster11,
                AppImages.poster12,
              ],
            ),

            const SizedBox(height: 32),

            AuthHeader(
              title: "Secure Your Account",
              subtitle: "Create a password to keep your PlotLine account safe.",
            ),

            const SizedBox(height: 24),

            BasicTextField(
              controller: _passwordController,
              label: 'Password',
              prefixIcon: Icons.lock_outline,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),

            const SizedBox(height: 16),

            BasicTextField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              prefixIcon: Icons.lock_outline,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),

            const SizedBox(height: 16),

            BasicAppButton(
              title: "Create Account",
              onPressed: () {},
              backgroundColor: context.theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
