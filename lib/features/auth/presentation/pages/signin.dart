import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/validators/email_validator.dart';
import 'package:plotline_mobile/common/validators/password_validator.dart';
import 'package:plotline_mobile/common/widgets/appbar/app_bar.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';
import 'package:plotline_mobile/common/widgets/logo/plotline_logo.dart';
import 'package:plotline_mobile/common/widgets/text_field/basic_text_field.dart';
import 'package:plotline_mobile/core/configs/assets/app_posters.dart';
import 'package:plotline_mobile/features/auth/data/requests/signin_user_req.dart';
import 'package:plotline_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:plotline_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:plotline_mobile/features/auth/presentation/bloc/auth_state.dart';
import 'package:plotline_mobile/features/auth/presentation/pages/signup.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/auth_header.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/auth_prompt.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/poster_header.dart';
import 'package:plotline_mobile/features/main_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    final emailError = EmailValidator.validate(_emailController.text.trim());
    final passwordError = PasswordValidator.validatePassword(
      _passwordController.text,
    );

    setState(() {
      _emailError = emailError;
      _passwordError = passwordError;
    });

    if (emailError != null) {
      _emailFocus.requestFocus();
      return;
    }

    if (passwordError != null) {
      _passwordFocus.requestFocus();
      return;
    }

    final signinUserReq = SigninUserReq(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    context.read<AuthBloc>().add(SigninSubmitted(signinUserReq: signinUserReq));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.theme.colorScheme.error,
            ),
          );
        } else if (state is SigninSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const MainPage(),
            ),
          );
        }
      },

      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: BasicAppBar(title: PlotlineLogo()),
          bottomNavigationBar: AuthPrompt(
            prompt: "Don't have an account?",
            actionText: "Register",
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SignupPage(),
                ),
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

                const AuthHeader(
                  title: "Sign In",
                  subtitle: "Your next movie story starts here.",
                ),

                const SizedBox(height: 24),

                // Email Field
                BasicTextField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  label: 'Email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  errorText: _emailError,
                  onChanged: (_) {
                    if (_emailError != null) {
                      setState(() => _emailError = null);
                    }
                  },
                ),

                const SizedBox(height: 10),

                // Password Field
                BasicTextField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  label: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  errorText: _passwordError,
                  onChanged: (_) {
                    if (_passwordError != null) {
                      setState(() => _passwordError = null);
                    }
                  },
                  onSubmitted: (_) => _validateAndSubmit(),
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
                  onPressed: isLoading ? () {} : _validateAndSubmit,
                  title: isLoading
                      ? SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: context.isDarkMode
                                ? Colors.black
                                : Colors.white,
                          ),
                        )
                      : const Text("Sign In"),
                  backgroundColor: context.theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
