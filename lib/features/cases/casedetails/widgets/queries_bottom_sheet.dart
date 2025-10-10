import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomQuerySheet {
  static void showsheet({
    required BuildContext context,
    required String heading,
    required List<Widget> content,
    Widget? actionButton,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;

        return Container(
          height: screenHeight * 0.9, 
          padding: EdgeInsets.only(
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 15,
            right: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset("assets/svg/back_arrow_svg.svg"),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      heading,
                      style: AppFonts.semiratechart,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset("assets/svg/close_svg_button.svg"),
                  ),
                  const SizedBox(width: 15),
                ],
              ),

              const SizedBox(height: 10),
              Divider(color: AppColors.hint2color, thickness: 1),
              const SizedBox(height: 10),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...content,
                      if (actionButton != null) ...[
                        const SizedBox(height: 20),
                        actionButton,
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
