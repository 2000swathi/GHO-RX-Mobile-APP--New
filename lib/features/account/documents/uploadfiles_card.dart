import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class UploadfilesCard extends StatelessWidget {
  const UploadfilesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20), 
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primarycolor.withOpacity(
                  0.1,
                ), 
              ),
              child: SvgPicture.asset(
                "assets/svg/account/cloud_upload.svg",
                height: 40,
              ),
            ),
            SizedBox(height: 30),
            Text("Click to upload", style: AppFonts.semiratechart),
            Text(
              "or drag and drop",
              style: AppFonts.hinttext2.copyWith(fontSize: 14),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "PDF, DOC, JPG, PNG up to 10MB",
                style: AppFonts.subtext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
