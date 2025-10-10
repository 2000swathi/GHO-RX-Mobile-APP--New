import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/final_opinion_confirmation.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/cases_tab_view.dart';

class CaseDetailsPage extends StatelessWidget {
  const CaseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 40,
        leading: Padding(
          padding: EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: SvgPicture.asset("assets/svg/Vector.svg"),
            ),
          ),
        ),
        title: Text("Case ID: GHO-2024-9481", style: AppFonts.subheading),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFE3F2FD),
              child: SvgPicture.asset(
                'assets/svg/email_svg.svg',
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Patient: John Doe",
                    style: AppFonts.subheading16.copyWith(fontSize: 14),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/qaPage");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightgreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'In Review',
                        style: AppFonts.textprimarygreen,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/person.svg",
                    colorFilter: ColorFilter.mode(
                      AppColors.textPrimary,
                      BlendMode.srcIn,
                    ),
                    width: 16,
                  ),
                  SizedBox(width: 7),
                  Text(
                    "Male",
                    style: AppFonts.subheading16.copyWith(fontSize: 14),
                  ),
                  SizedBox(width: 15),
                  SvgPicture.asset("assets/svg/calender.svg"),
                  SizedBox(width: 7),
                  Text(
                    "12 Dec 1987 (38 years)",
                    style: AppFonts.subheading16.copyWith(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "3 hours left",
                    style: AppFonts.textSecondary.copyWith(
                      fontSize: 14,
                      color: AppColors.red,
                    ),
                  ),
                  SizedBox(width: 3),
                  Icon(Icons.circle, size: 6, color: AppColors.red),
                  SizedBox(width: 3),
                  Text(
                    "Due Date: Oct 14, 2025",
                    style: AppFonts.textSecondary.copyWith(
                      fontSize: 14,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              CustomButton(
                text: "Submit Review",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinalOpinionConfirmation(),
                    ),
                  );
                },
              ),
              SizedBox(height: 14),
              CasesTabView(),

              SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}
