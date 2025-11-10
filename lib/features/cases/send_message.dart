import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/svg/Frame 1.svg", height: 26),
                    SizedBox(width: 8),
                    Text(
                      "Send an Email",
                      style: AppFonts.buttontxt.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.close, color: AppColors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Divider(thickness: 0.8),
            Row(
              children: [
                Text(
                  "From:",
                  style: AppFonts.buttontxt.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "abchospital@gmail.com",
                    style: AppFonts.buttontxt.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  "Cc  ",
                  style: AppFonts.buttontxt.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "Bcc",
                  style: AppFonts.buttontxt.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Divider(thickness: 0.8),
            Row(
              children: [
                Text(
                  "To:",
                  style: AppFonts.buttontxt.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "sophiyajohn34@gmail.com",
                    style: AppFonts.buttontxt.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Divider(thickness: 0.8),

            SizedBox(height: 4),
            Text(
              "Subject:",
              style: AppFonts.buttontxt.copyWith(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 6),

            Container(
              height: 160,
              decoration: BoxDecoration(
                color: AppColors.backgroundcolor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.backgroundcolor.withAlpha(80),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                expands: true,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your message here..',
                  hintStyle: TextStyle(color: AppColors.hint2color),
                ),
              ),
            ),

            SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/svg/iconsax-archive.svg",
                    height: 16,
                    width: 16,
                  ),
                  label: Text(
                    "Save Draft",
                    style: AppFonts.buttontxt.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Discard",
                        style: AppFonts.buttontxt.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      width: 80,
                      child: CustomButton(
                        color: AppColors.primarycolor,
                        colortext: AppColors.white,
                        text: "Send",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
