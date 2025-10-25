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

import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthSuccess) {
          CustomSnackbar.show(context, "Login Successfull.Welcome!", true);
          await Navigator.pushNamed(
            context,
            '/otp',
            arguments: state.otpResponse,
          );
        } else if (state is AuthFailure) {
          CustomSnackbar.show(context, state.error, false);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 100),
                          CustomLogo(),
                          SizedBox(height: 30),
                          Text("Welcome to GHORx", style: AppFonts.heading),
                          SizedBox(height: 18),
                          Text(
                            "Log in to streamline global case acceptance and secure teleconsultations. Efficiency meets expert collaboration.",
                            style: AppFonts.subtext,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            name: "Email",
                            hintText: "Enter your email",
                            controller: emailController,
                            validator: Validation.validateEmail,
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            name: "Password",
                            hintText: "Enter your password",
                            controller: passwordController,
                            obscureText: _obscurePassword,
                            validator: Validation.validatePassword,
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
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Forget Password?",
                                  style: AppFonts.labelItalic,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return LoadingAnimation();
                              }
                              return CustomButton(
                                text: "Sign In",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      LoginRequested(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          Spacer(),
                          Text(
                            "Not a reviewer yet? Request to join GHO’s Reviewer Network.",
                            textAlign: TextAlign.center,
                            style: AppFonts.hinttext2,
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/addPage');
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: 1),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.textPrimary,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Join Reviewer Network",
                                style: AppFonts.textprimary.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
