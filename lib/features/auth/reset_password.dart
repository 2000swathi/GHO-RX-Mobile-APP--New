import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLogo(),
            SizedBox(height: 20),
            Text("Reset Password", 
            style: AppFonts.heading,
            ),
            SizedBox(height: 20),
            Text("OTP has been sent on your registered mobile number and email.",
            style: AppFonts.subtext,
            textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            CustomTextFormField(
              name: "New Password",
              hintText: "Enter your strong password"),
            SizedBox(height: 20),
            CustomTextFormField(
              name: "Confirm Password",
              hintText: "Repeat your Password"),
            SizedBox(height: 40),
            CustomButton(
              text: "Confirm",
              onPressed: () {}
            ),
          ],
        ),
      ),
    );
  }
}