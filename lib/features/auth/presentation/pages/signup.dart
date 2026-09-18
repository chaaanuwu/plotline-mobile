import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/widgets/appbar/app_bar.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';
import 'package:plotline_mobile/common/widgets/logo/plotline_logo.dart';
import 'package:plotline_mobile/common/widgets/text_field/basic_text_field.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/features/auth/presentation/pages/signin.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/auth_header.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/auth_prompt.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/poster_header.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: PlotlineLogo()),
      bottomNavigationBar: AuthPrompt(
        prompt: "Already have an account?",
        actionText: "Login",
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => SigninPage()),
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
              title: "Create Account",
              subtitle: "Join PlotLine and start your movie journey.",
            ),

            const SizedBox(height: 24),

            // firstname field
            BasicTextField(
              controller: _firstNameController,
              label: "First Name",
              prefixIcon: Icons.person_outlined,
              textInputAction: TextInputAction.next,
            ),

            const SizedBox(height: 10),

            // lastname field
            BasicTextField(
              controller: _lastNameController,
              label: "Last Name",
              prefixIcon: Icons.person_outlined,
              textInputAction: TextInputAction.next,
            ),

            const SizedBox(height: 10),

            // email field
            BasicTextField(
              controller: _emailController,
              label: "Email",
              prefixIcon: Icons.email_outlined,
              textInputAction: TextInputAction.done,
            ),

            const SizedBox(height: 16),

            BasicAppButton(title: "Continue", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
