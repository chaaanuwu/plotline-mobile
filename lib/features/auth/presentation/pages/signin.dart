import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/appbar/app_bar.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';
import 'package:plotline_mobile/common/widgets/text_field/basic_text_field.dart';
import 'package:plotline_mobile/common/widgets/logo/plotline_logo.dart';
import 'package:plotline_mobile/features/auth/presentation/pages/signup.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/auth_header.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/auth_prompt.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/poster_header.dart';
import 'package:plotline_mobile/features/auth/data/models/signin_user_req.dart';
import 'package:plotline_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:plotline_mobile/features/auth/presentation/bloc/auth_event.dart';

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
      bottomNavigationBar: AuthPrompt(
        prompt: "Don't have an account?",
        actionText: "Register",
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => SignupPage()),
          );
        },
      ),
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

            AuthHeader(
              title: "Sign In",
              subtitle: "Your next movie story starts here.",
            ),

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
              onPressed: () {
                final signinUserReq = SigninUserReq(
                  email: _emailController.text.trim(),
                  password: _passwordController.text,
                );

                context.read<AuthBloc>().add(
                  SigninSubmitted(signinUserReq: signinUserReq),
                );
              },
              title: "Sign In",
              backgroundColor: context.theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
