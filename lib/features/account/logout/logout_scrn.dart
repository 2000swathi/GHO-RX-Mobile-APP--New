import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_dialog.dart';
import 'package:ghorx_mobile_app_new/features/authentication/bloc/auth_bloc.dart';
import 'package:ghorx_mobile_app_new/features/authentication/bloc/auth_event.dart';

class LogoutScrn extends StatelessWidget {
  const LogoutScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return customDialog(
      svgPath: "assets/svg/account/logout.svg",
      heading: "Log Out",
      warningText: "Are you sure you want to log out?",
      btnTxt1: "cancel",
      btnTextClr: AppColors.primarycolor,
      btnTxt2: "Yes, Log Out",
      btnbg1: AppColors.textPrimary.withAlpha(15),
      btnbg2: AppColors.primarycolor,
      colors: AppColors.primarycolor.withAlpha(15),
      imgColor: AppColors.primarycolor,
      btn2pressed: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        ); // close dialog
        context.read<AuthBloc>().add(Logout());
      },
    );
  }
}
