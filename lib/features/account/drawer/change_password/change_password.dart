import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_snackbar.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/account/drawer/change_password/repo/bloc/change_password_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/drawer/change_password/repo/bloc/change_password_event.dart';
import 'package:ghorx_mobile_app_new/features/account/drawer/change_password/widget/commonTextfield.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentPWcontroller = TextEditingController();

  final TextEditingController newPWcontroller = TextEditingController();

  final TextEditingController confirmPWcontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _currentPw = true;
  bool _newPw = true;
  bool _confirmPw = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is CPSuccess) {
          // CustomSnackbar.show(context, "Password Changed Successfully!", true);
          final message =
              state.message.isNotEmpty
                  ? state.message
                  : "Password updated successfully";

          CustomSnackbar.show(context, message, true);

          Navigator.pushNamed(context, '/login', arguments: state.message);
        } else if (state is CPError) {
          CustomSnackbar.show(context, state.message, false);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundcolor,
        appBar: CustomAccountAppBar(title: "Change Password"),

        body: Padding(
          padding: const EdgeInsets.only(
            left: 22,
            right: 22,
            // top: 5,
            // bottom: 5,
          ),
          child: Form(
            key: _formKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          SizedBox(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.primarycolor.withAlpha(
                                15,
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: SvgPicture.asset(
                                    // width: 50,
                                    // height: 50,
                                    "assets/svg/account/lock.svg",
                                    colorFilter: ColorFilter.mode(
                                      AppColors.primarycolor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Reset your password",
                            style: AppFonts.header_5.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "To update your password, enter your current and new passwords below.",
                            style: AppFonts.subtext,
                          ),
                          SizedBox(height: 30),
                          commonTextfield(
                            controller: currentPWcontroller,
                            obscureText: _currentPw,
                            titletext: "Current Password",
                            hintText: "Enter your current password",
                            validatepw: Validation.validatePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _currentPw
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.hint1color,
                              ),
                              onPressed: () {
                                setState(() {
                                  _currentPw = !_currentPw;
                                });
                              },
                            ),
                          ),
                          commonTextfield(
                            titletext: "New Password",
                            hintText: "Enter your new password",
                            controller: newPWcontroller,
                            obscureText: _newPw,
                            validatepw: Validation.validatePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _newPw
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.hint1color,
                              ),
                              onPressed: () {
                                setState(() {
                                  _newPw = !_newPw;
                                });
                              },
                            ),
                          ),
                          commonTextfield(
                            titletext: "Confirm Password",
                            hintText: "Confirm password",
                            controller: confirmPWcontroller,
                            obscureText: _confirmPw,
                            validatepw:
                                (value) => Validation.confirmPasswordValidator(
                                  value,
                                  newPWcontroller,
                                ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmPw
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.hint1color,
                              ),
                              onPressed: () {
                                setState(() {
                                  _confirmPw = !_confirmPw;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 8),
                          BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                            builder: (context, state) {
                              return CustomButton(
                                text: "Change Password",
                                onPressed: () {
                                  // Validate the form before sending event
                                  if (_formKey.currentState!.validate()) {
                                    context.read<ChangePasswordBloc>().add(
                                      FetchChangePassword(
                                        currentPw:
                                            currentPWcontroller.text.trim(),
                                        newPw: newPWcontroller.text.trim(),
                                        confirmPw:
                                            confirmPWcontroller.text.trim(),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
