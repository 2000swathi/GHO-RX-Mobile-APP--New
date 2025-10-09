import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/finalsubmission.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/cases_tab_view.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/medicalreport.dart';

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
                    colorFilter: ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
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
              SizedBox(height: 14),
               Container(
                padding:  EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Summary", style: AppFonts.subheading16),
                    SizedBox(height: 8),
                    Text(
                      "I am a 60-year-old male experiencing slurred speech and weakness in my right arm for the past 2 hours. I consulted a doctor who mentioned it could be a possible stroke and advised immediate admission for further tests and treatment. As I am not fully convinced with the explanation and plan provided, I am seeking anurgent second opinion from a .",
                        style: AppFonts.textprimary,
                    ),
                  ],
                ),
              ),
               SizedBox(height: 14),
              Medicalreport(),
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
                    Flexible(child: CustomButton(text: "Submit Opinion", onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Finalsubmission()));
                    })),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("overview", style: AppFonts.header_red),
                    const SizedBox(height: 8),
                    Text(
                      "60-year-old male with slurred speech and weakness in right arm for 2 hours. Requesting urgent neurologist opinion.",
                      style: AppFonts.textprimary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const CasesTabView(),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}
