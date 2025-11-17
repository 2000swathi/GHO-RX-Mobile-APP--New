import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomQuerySheet {
  static void showsheet({
    required BuildContext context,
    required String heading,
    required List<Widget> content,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (_, controller) {
            return SingleChildScrollView(
              controller: controller,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom:
                    MediaQuery.of(context).viewInsets.bottom +
                    20, 
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/back_arrow_svg.svg"),

                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(heading, style: AppFonts.semiratechart),
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            "assets/svg/close_svg_button.svg",
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  ...content,
                ],
              ),
            );
          },
        );
      },
    );
  }
}
