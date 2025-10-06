import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

// ignore: must_be_immutable
class CustomLogo extends StatelessWidget {
  bool? isSplash;
  bool? isSmall;
  MainAxisAlignment mainAxisAlignment;
  CustomLogo({
    super.key,
    this.isSplash = false,
    this.isSmall = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    double height =
        isSplash == true
            ? 43.9296875.h
            : isSmall == true
            ? 21.462844848632812
            : 33.28564453125.h;
    double width =
        isSplash == true
            ? 61.501220703125.w
            : isSmall == true
            ? 30.047983169555664
            : 46.59990310668945.w;
    double width2 =
        isSplash == true
            ? 126.5166015625.w
            : isSmall == true
            ? 61.8125
            : 95.86229705810547.w;
    return Row(
      mainAxisAlignment: mainAxisAlignment,
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
          child: Icon(
            Icons.add,
            color: AppColors.white,
            size:
                isSplash == true
                    ? 24
                    : isSmall == true
                    ? 15
                    : 20,
            weight: 900,
          ),
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
          child: Center(
            child: Text(
              "GHORx",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize:
                    isSplash == true
                        ? 24
                        : isSmall == true
                        ? 15
                        : 20,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
