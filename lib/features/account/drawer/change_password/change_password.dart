import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_snackbar.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/drawer/change_password/repo/bloc/change_password_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/drawer/change_password/repo/bloc/change_password_event.dart';
import 'package:ghorx_mobile_app_new/features/account/drawer/change_password/widget/commonTextfield.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  final TextEditingController currentPWcontroller = TextEditingController();
  final TextEditingController newPWcontroller = TextEditingController();
  final TextEditingController confirmPWcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is CPSuccess) {
          CustomSnackbar.show(context, "Password Changed Successfully!", true);
          Navigator.pushNamed(context, '/login', arguments: state.message);
        } else if (state is CPError) {
          CustomSnackbar.show(context, state.message, false);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.backgroundcolor,
        appBar: CustomAccountAppBar(title: "Change Password"),

        body: Padding(
          padding: const EdgeInsets.only(left: 22, right: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 52.5),
              CircleAvatar(
                radius: 54,
                backgroundColor: AppColors.primarycolor.withAlpha(15),
                child: Center(
                  child: SvgPicture.asset(
                    width: 50,
                    height: 50,
                    "assets/svg/account/lock.svg",
                    colorFilter: ColorFilter.mode(
                      AppColors.primarycolor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Reset your password",
                style: AppFonts.header_5.copyWith(fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 4),
              Text(
                "To update your password, enter your current and new passwords below.",
                style: AppFonts.subtext,
              ),
              SizedBox(height: 40),
              commonTextfield(
                controller: currentPWcontroller,
                titletext: "Current Password",
                hintText: "Enter your current password",
              ),
              commonTextfield(
                titletext: "New Password",
                hintText: "Enter your new password",
                controller: newPWcontroller,
              ),
              commonTextfield(
                titletext: "Confirm Password",
                hintText: "Confirm password",
                controller: confirmPWcontroller,
              ),
              SizedBox(height: 54),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 22,
            right: 22,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: CustomButton(
            text: "Change Password",
            onPressed: () {
              context.read<ChangePasswordBloc>().add(
                FetchChangePassword(
                  currentPw: currentPWcontroller.text.trim(),
                  newPw: newPWcontroller.text.trim(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
