import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

// ignore: must_be_immutable
class CustomLogo extends StatelessWidget {
  bool? isSplash;
  CustomLogo({super.key, this.isSplash = false});

  @override
  Widget build(BuildContext context) {
    double height = isSplash == true ? 43.9296875.h : 33.28564453125.h;
    double width = isSplash == true ? 61.501220703125.w : 46.59990310668945.w;
    double width2 = isSplash == true ? 126.5166015625.w : 95.86229705810547.w;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height,
          width: width,
          margin: EdgeInsets.only(right: 2),
          decoration: BoxDecoration(
            color: AppColors.primarycolor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26.36),
              bottomLeft: Radius.circular(26.36),
            ),
          ),
          child: Icon(Icons.add, color: AppColors.white, size: 24,weight: 900),
        ),

        Container(
          height: height,
          width: width2,
          decoration: BoxDecoration(
            color: AppColors.primarycolor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(26.36),
              bottomRight: Radius.circular(26.36),
            ),
          ),
          child: Center(child: Text("GHORx",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          )
          ),
          ),
        ),
      ],
    );
  }
}
