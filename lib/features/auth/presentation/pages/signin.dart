import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/appbar/app_bar.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';
import 'package:plotline_mobile/common/widgets/logo/plotline_logo.dart';
import 'package:plotline_mobile/common/widgets/poster_header/poster_header.dart';
import 'package:plotline_mobile/common/widgets/text_field/basic_text_field.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: PlotlineLogo()),
      bottomNavigationBar: _signupText(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 24, 30, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PosterHeader(
              posters: [
                AppImages.poster1,
                AppImages.poster2,
                AppImages.poster3,
                AppImages.poster4,
              ],
            ),

            const SizedBox(height: 32),

            _header(context),

            const SizedBox(height: 24),

            // email field
            BasicTextField(
              controller: _emailController,
              label: 'Email',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),

            const SizedBox(height: 10),

            // password field
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

            BasicAppButton(
              onPressed: () {},
              title: "Sign In",
              backgroundColor: context.theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  // Header
  Widget _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sign In",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Your next movie story starts here.",
          style: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: context.theme.textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }

  // Signup
  Widget _signupText(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: TextStyle(
                fontSize: 14,
                color: context.theme.colorScheme.onSurfaceVariant,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: context.theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
