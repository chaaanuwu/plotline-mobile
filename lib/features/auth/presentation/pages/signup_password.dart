import 'package:flutter/material.dart';
import 'package:plotline_mobile/features/auth/data/models/signup_data.dart';

class SignupPasswordPage extends StatefulWidget {
  final SignupData signupData;

  const SignupPasswordPage({super.key, required this.signupData});

  @override
  State<SignupPasswordPage> createState() => _SignupPasswordPageState();
}

class _SignupPasswordPageState extends State<SignupPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
