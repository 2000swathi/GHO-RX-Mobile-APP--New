import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class CommonQa extends StatelessWidget {
  final String question;
  final String ans;
  final String support;

  const CommonQa({super.key, required this.question, required this.ans,required this.support});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SvgPicture.asset("assets/svg/blueBullet.svg"),
            ),
            SizedBox(width: 10.25.w),
            Flexible(
              child: Text(
                question,
                style: AppFonts.buttontxt.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        Text("Answer : ${ans}",style: AppFonts.buttontxt.copyWith(color: AppColors.successcolor),),
        SizedBox(height: 7,),
        Text("Support : ${support}",style: AppFonts.buttontxt.copyWith(color: AppColors.successcolor)),
         SizedBox(height: 10,),
      ],
    );
  }
}
