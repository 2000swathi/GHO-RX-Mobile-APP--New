import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class ProfileDtlContainer extends StatefulWidget {
  final String heading;
  final String subheading;
  final Widget info;

  const ProfileDtlContainer({
    super.key,
    required this.heading,
    required this.subheading,
    required this.info,
  });

  @override
  State<ProfileDtlContainer> createState() => _ProfileDtlContainerState();
}

class _ProfileDtlContainerState extends State<ProfileDtlContainer> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 25),
      padding: const EdgeInsets.only(left: 15, right: 20, top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.heading,
                        style: AppFonts.buttontxt.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        widget.subheading,
                        style: AppFonts.subtext.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                _isExpanded == true
                    ? SvgPicture.asset("assets/svg/arrow_up_svg.svg")
                    : SvgPicture.asset("assets/svg/arrow_under_svg.svg"),
              ],
            ),
            _isExpanded == true
                ? Column(
                  children: [
                    Divider(color: AppColors.hint2color),
                    widget.info,
                    SizedBox(height: 15),
                    CustomButton(
                      text: "Edit",
                      widget: SvgPicture.asset("assets/svg/edit_svg.svg"),
                      isiIon: true,
                      color: AppColors.primarycolor.withAlpha(15),
                      onPressed: () {},
                    ),
                  ],
                )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
