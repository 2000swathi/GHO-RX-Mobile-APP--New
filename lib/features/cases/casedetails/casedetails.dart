import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
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
                      color: const Color(0xffE8F5E9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('In Review', style: AppFonts.textprimarygreen),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Allotted Time: 6 hrs", style: AppFonts.textSecondary),
                  const SizedBox(width: 4),
                  Icon(Icons.circle, size: 6, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text("Due Date: Oct 14, 2025", style: AppFonts.textSecondary),
                ],
              ),
              //1st container
              const SizedBox(height: 14),
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
                    // ActionButtonCard(
                    //   text: "Submit Opinion",
                    //   isFilled: true,
                    //   onTap: () async {},
                    // ),
                    Flexible(child: CustomButton(text: "Submit Opinion", onPressed: () {})),
                  ],
                ),
              ),
              //2nd container
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
              //srollview tab
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
