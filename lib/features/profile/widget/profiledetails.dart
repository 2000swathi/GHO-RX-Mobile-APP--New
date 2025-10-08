import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

// ignore: must_be_immutable
class ProfileDetails extends StatelessWidget {
  String heading;
  void Function() ontap;
  ProfileDetails({super.key, required this.heading, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.arrow_outward_sharp, color: AppColors.primarycolor),
            Text(heading, style: AppFonts.subheading),
            Spacer(),
            InkWell(
              onTap: ontap,
              child: Text("Click here", style: AppFonts.labelItalic),
            ),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
