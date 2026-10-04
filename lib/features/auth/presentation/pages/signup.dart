import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/validators/email_validator.dart';
import 'package:plotline_mobile/common/validators/input_validator.dart';
import 'package:plotline_mobile/common/widgets/appbar/app_bar.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';
import 'package:plotline_mobile/common/widgets/logo/plotline_logo.dart';
import 'package:plotline_mobile/common/widgets/text_field/basic_text_field.dart';
import 'package:plotline_mobile/core/configs/assets/app_posters.dart';
import 'package:plotline_mobile/features/auth/presentation/models/signup_data.dart';
import 'package:plotline_mobile/features/auth/presentation/pages/signin.dart';
import 'package:plotline_mobile/features/auth/presentation/pages/signup_details.dart';
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

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  String? _firstNameValidationError;
  String? _lastNameValidationError;
  String? _emailValidationError;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    final firstNameError = InputValidator.validateFirstName(
      _firstNameController.text,
    );
    final lastNameError = InputValidator.validateLastName(
      _lastNameController.text,
    );
    final emailError = EmailValidator.validate(_emailController.text);

    setState(() {
      _firstNameValidationError = firstNameError;
      _lastNameValidationError = lastNameError;
      _emailValidationError = emailError;
    });

    if (firstNameError == null && lastNameError == null && emailError == null) {
      final SignupData signupData = SignupData(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              SignupDetailsPage(signupData: signupData),
        ),
      );
    } else {
      if (firstNameError != null) {
        _firstNameFocus.requestFocus();
      } else if (lastNameError != null) {
        _lastNameFocus.requestFocus();
      } else if (emailError != null) {
        _emailFocus.requestFocus();
      }
    }
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
                AppPosters.poster1,
                AppPosters.poster2,
                AppPosters.poster3,
                AppPosters.poster4,
              ],
            ),

            const SizedBox(height: 32),

            AuthHeader(
              title: "Create Account",
              subtitle: "Join PlotLine and start your movie journey.",
            ),

            const SizedBox(height: 24),

            // Firstname field
            BasicTextField(
              controller: _firstNameController,
              focusNode: _firstNameFocus,
              label: "First Name",
              prefixIcon: Icons.person_outlined,
              textInputAction: TextInputAction.next,
              errorText: _firstNameValidationError,
              onChanged: (_) {
                if (_firstNameValidationError != null) {
                  setState(() => _firstNameValidationError = null);
                }
              },
            ),

            const SizedBox(height: 10),

            // Lastname field
            BasicTextField(
              controller: _lastNameController,
              focusNode: _lastNameFocus,
              label: "Last Name",
              prefixIcon: Icons.person_outlined,
              textInputAction: TextInputAction.next,
              errorText: _lastNameValidationError,
              onChanged: (_) {
                if (_lastNameValidationError != null) {
                  setState(() => _lastNameValidationError = null);
                }
              },
            ),

            const SizedBox(height: 10),

            // Email field
            BasicTextField(
              controller: _emailController,
              focusNode: _emailFocus,
              label: "Email",
              prefixIcon: Icons.email_outlined,
              textInputAction: TextInputAction.done,
              errorText: _emailValidationError,
              onChanged: (_) {
                if (_emailValidationError != null) {
                  setState(() => _emailValidationError = null);
                }
              },
            ),

            const SizedBox(height: 16),

            BasicAppButton(
              title: Text("Continue"),
              onPressed: _validateAndSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
