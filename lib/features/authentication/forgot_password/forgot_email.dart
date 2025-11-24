import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_snackbar.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/authentication/bloc/auth_bloc.dart';
import 'package:ghorx_mobile_app_new/features/authentication/bloc/auth_event.dart';
import 'package:ghorx_mobile_app_new/features/authentication/bloc/auth_state.dart';
import 'package:ghorx_mobile_app_new/features/authentication/forgot_password/widget/bottom_sheet.dart';

class ForgotEmailScreen extends StatelessWidget {
  ForgotEmailScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is ForgotEmailSuccess) {
          showEmailSentBottomSheet(context);
        } else if (state is AuthFailure) {
          CustomSnackbar.show(context, state.error, false);
        }
      },
      child: Scaffold(
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
                  Text("Forgot Password", style: AppFonts.heading),
                  SizedBox(height: 20),
                  Text(
                    "Enter your registered email ID to receive a verification code.",
                    style: AppFonts.subtext,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  CustomTextFormField(
                    name: "Email",
                    hintText: "Enter your email address",
                    controller: emailController,
                    validator: Validation.validateEmail,
                  ),

                  SizedBox(height: 85),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return LoadingAnimation();
                      }
                      return CustomButton(
                        text: "Verify",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              ForgotEmail(email: emailController.text.trim()),
                            );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Return to Login",
                      style: AppFonts.textblue.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primarycolor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
