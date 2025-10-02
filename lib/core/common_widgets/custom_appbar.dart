import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final int currentStep;
  final int totalSteps;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.backgroundcolor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.offgreycolor,
            width: 1,
          )
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFonts.textblue,
                  ),
                   SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        subtitle,
                        style: AppFonts.textappbar,
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.keyboard_arrow_down, size: 20),
                    ],
                  ),
                ],
              ),
        
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: (currentStep - 1) / (totalSteps - 1),
                        strokeWidth: 4,
                        backgroundColor: AppColors.offgreycolor,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primarycolor),
                      ),
                    ),
                    Text(
                      "$currentStep of $totalSteps",
                      style: AppFonts.textprogressbar,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}