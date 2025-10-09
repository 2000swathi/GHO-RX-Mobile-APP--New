import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomBottomSheet {
  static void show({
    required BuildContext context,
    required String heading,
    required List<Widget> content,
    required Widget actionButton,
  }) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;

        return SizedBox(
          height: screenHeight * 0.9,

          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              left: 15,
              right: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          "assets/svg/back_arrow_svg.svg",
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(heading, style: AppFonts.semiratechart),
                      const Spacer(),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          "assets/svg/close_svg_button.svg",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Color(0xffE7E9EF), thickness: 1),
                  const SizedBox(height: 10),
                  ...content,
                  const SizedBox(height: 20),
                  actionButton,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
