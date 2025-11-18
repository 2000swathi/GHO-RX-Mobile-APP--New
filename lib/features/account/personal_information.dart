import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, 
            size: 24,
            color: AppColors.black,
            ),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          "Personal Information",
          style: AppFonts.heading,
        ),

        actions: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/account/pencil.svg",
                height: 20,
              ),
              const SizedBox(width: 6),
              Text(
                "Edit",
                style: AppFonts.textblue,
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),

      body: const Center(
        child: Text("bvxhbj"),
      ),
    );
  }
}
