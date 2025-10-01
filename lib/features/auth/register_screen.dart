import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();


   RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLogo(),
            SizedBox(height: 20),
            Text("Welcome to GHORx", style: AppFonts.heading),
            Text(
              "Log in to streamline global case acceptance and secure teleconsultations. Efficiency meets expert collaboration.",
              style: AppFonts.subtext,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              name: "First Name",
              hintText: "Enter your first name",
              controller: firstnameController,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              name: "Last Name",
              hintText: "Enter your last name",
              controller: lastnameController,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              name: "Email",
              hintText: "Enter your email",
              controller: emailController,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              name: "Password",
              hintText: "Enter your password",
              controller: passwordController,
              obscureText: true,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.visibility),
              ),
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              name: "Confirm Password",
              hintText: "Enter the password again",
              controller: confirmpasswordController,
              obscureText: true,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.visibility),
              ),
            ),
            SizedBox(height: 30),
            CustomButton(
              text: "Sign Up",
              onPressed: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}