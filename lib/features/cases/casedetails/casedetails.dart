import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/finalsubmission.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/medicalreport.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/medications.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/patientqueries.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/summary.dart';

class CaseDetailsPage extends StatelessWidget {
  const CaseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SvgPicture.asset("assets/svg/Vector.svg"),
            ),
          ),
        ),
        title: Text("Case Details", style: AppFonts.heading),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFE3F2FD),
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Case ID: GHO-2024-9481", style: AppFonts.subheading),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightgreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('In Review', style: AppFonts.textprimarygreen),
                  ),
                ],
              ),
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
                    "Created: Oct 13, 2025",
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
              //pages
              SizedBox(height: 14),
              Summerypage(),
              SizedBox(height: 14),
              Container(
                margin: const EdgeInsets.all(1.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.hint2color.withAlpha(1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Audio Summary", style: AppFonts.subheading16),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primarycolor.withAlpha(30),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/svg/audio.svg',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 10),
                              Text('Audio Summary', style: AppFonts.buttontxt16),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primarycolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              minimumSize: Size.zero,
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/play.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Play',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              Medicalreport(),
              SizedBox(height: 14),
              Patientqueries(),
              SizedBox(height: 14),
              Medications(),
              SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Payout", style: AppFonts.header_4),
                        const SizedBox(height: 4),
                        Text("\$80.00", style: AppFonts.header_5),
                      ],
                    ),
                    SizedBox(width: 35),
                    Flexible(
                      child: CustomButton(
                        text: "Submit Opinion",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Finalsubmission(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}
