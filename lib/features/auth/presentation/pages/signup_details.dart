import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/widgets/appbar/app_bar.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';
import 'package:plotline_mobile/common/widgets/date_picker/date_picker.dart';
import 'package:plotline_mobile/common/widgets/logo/plotline_logo.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/features/auth/data/models/signup_data.dart';
import 'package:plotline_mobile/features/auth/presentation/pages/signup_password.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/auth_header.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/gender_selector.dart';
import 'package:plotline_mobile/features/auth/presentation/widgets/poster_header.dart';

class SignupDetailsPage extends StatelessWidget {
  final SignupData signupData;

  const SignupDetailsPage({super.key, required this.signupData});

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
                AppImages.poster5,
                AppImages.poster6,
                AppImages.poster7,
                AppImages.poster8,
              ],
            ),

            const SizedBox(height: 32),

            AuthHeader(
              title: "Tell Us About You",
              subtitle:
                  "A few details to personalize your PlotLine experience.",
            ),

            const SizedBox(height: 24),

            DatePickerField(
              onDateSelected: (date) {
                signupData.dob =
                    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
              },
            ),

            const SizedBox(height: 24),

            GenderSelector(
              onGenderSelected: (gender) {
                signupData.gender = gender;
              },
            ),

            const SizedBox(height: 36),

            BasicAppButton(
              title: "Continue",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SignupPasswordPage(signupData: signupData),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
