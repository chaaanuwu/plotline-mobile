import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/validators/password_validator.dart';
import 'package:plotline_mobile/common/widgets/appbar/app_bar.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';
import 'package:plotline_mobile/common/widgets/logo/plotline_logo.dart';
import 'package:plotline_mobile/common/widgets/text_field/basic_text_field.dart';
import 'package:plotline_mobile/core/configs/assets/app_posters.dart';
import 'package:plotline_mobile/features/auth/data/models/signup_data.dart';
import 'package:plotline_mobile/features/auth/data/models/signup_user_req.dart';
import 'package:plotline_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:plotline_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:plotline_mobile/features/auth/presentation/bloc/auth_state.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/auth_header.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/poster_header.dart';
import 'package:plotline_mobile/features/main_page.dart';

class SignupPasswordPage extends StatefulWidget {
  final SignupData signupData;

  const SignupPasswordPage({super.key, required this.signupData});

  @override
  State<SignupPasswordPage> createState() => _SignupPasswordPageState();
}

class _SignupPasswordPageState extends State<SignupPasswordPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _passwordValidationError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _createAccount() {
    final passwordValidationError = PasswordValidator.validatePassword(
      _passwordController.text,
    );

    final passwordValidationMatchError = PasswordValidator.validateMatch(
      _passwordController.text,
      _confirmPasswordController.text,
    );

    setState(() {
      _passwordValidationError = passwordValidationError;
      _confirmPasswordError = passwordValidationMatchError;
    });

    if (passwordValidationError != null ||
        passwordValidationMatchError != null) {
      return;
    }

    widget.signupData.password = _passwordController.text;

    final SignupUserReq signupUserReq = SignupUserReq(
      firstName: widget.signupData.firstName!,
      lastName: widget.signupData.lastName!,
      email: widget.signupData.email!,
      password: widget.signupData.password!,
      dob: widget.signupData.dob!,
      gender: widget.signupData.gender!,
    );

    context.read<AuthBloc>().add(SignupSubmitted(signupUserReq: signupUserReq));
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
        } else if (state is SignupSuccess) {
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(30, 24, 30, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PosterHeader(
                  posters: [
                    AppPosters.poster9,
                    AppPosters.poster10,
                    AppPosters.poster11,
                    AppPosters.poster12,
                  ],
                ),

                const SizedBox(height: 32),

                AuthHeader(
                  title: "Secure Your Account",
                  subtitle:
                      "Create a password to keep your PlotLine account safe.",
                ),

                const SizedBox(height: 24),

                BasicTextField(
                  controller: _passwordController,
                  label: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.next,
                  errorText: _passwordValidationError,
                  onChanged: (_) {
                    if (_passwordValidationError != null) {
                      setState(() {
                        _passwordValidationError = null;
                      });
                    }
                  },
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
                  obscureText: _obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  errorText: _confirmPasswordError,
                  onChanged: (_) {
                    if (_confirmPasswordError != null) {
                      setState(() {
                        _confirmPasswordError = null;
                      });
                    }
                  },
                  onSubmitted: (_) => _createAccount(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                BasicAppButton(
                  onPressed: isLoading ? () {} : _createAccount,
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
                      : const Text("Create Account"),
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
