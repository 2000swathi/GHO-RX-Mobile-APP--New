import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
         child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 100),
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
                  hintText: "Enter your strong password",
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  validator: Validation.validatePassword,
                  ),
                SizedBox(height: 20),
                CustomTextFormField(
                  name: "Confirm Password",
                  hintText: "Repeat your Password",
                  controller: confirmpasswordController,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColors.hint1color,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                  validator: (value) => Validation.confirmPasswordValidator( value, passwordController),
                  ),
                SizedBox(height: 40),
                CustomButton(
                  text: "Confirm",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, '/login');
                    }
                  }
                ),
              ],
            ),
          ),
               ),
       ),
    );
  }
}