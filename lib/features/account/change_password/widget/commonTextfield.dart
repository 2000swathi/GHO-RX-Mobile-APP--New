import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class commonTextfield extends StatelessWidget {
  final String titletext;
  final String hintText;
  final TextEditingController controller;
  const commonTextfield({
    super.key,
    required this.titletext,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titletext, style: AppFonts.textSecondary),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              top: 20,
              bottom: 20,
              right: 20,
              left: 20,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
                right: 7,
                left: 20,
              ),
              child: SvgPicture.asset(
                "assets/svg/account/lock.svg",
                colorFilter: ColorFilter.mode(
                  AppColors.primarycolor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            hintText: hintText,
            hintStyle: AppFonts.hinttext2,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
                right: 20,
                left: 20,
              ),
              child: SvgPicture.asset("assets/svg/account/pweye.svg"),
            ),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
