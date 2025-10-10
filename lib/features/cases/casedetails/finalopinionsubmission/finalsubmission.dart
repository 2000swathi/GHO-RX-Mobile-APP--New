import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/pages/recordaudio.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/pages/writtenreport.dart';

class Finalsubmission extends StatefulWidget {
  const Finalsubmission({super.key});

  @override
  State<Finalsubmission> createState() => _FinalsubmissionState();
}

class _FinalsubmissionState extends State<Finalsubmission>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
        title: Text("Final opinion Submission", style: AppFonts.heading),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Specialist Second Opinion Report",
                style: AppFonts.subheading,
              ),
              SizedBox(height: 10),
              Text(
                'Provide a clear, detailed clinical assessment. This will be the patient-facing final document.',
                style: AppFonts.textSecondary,
              ),
              SizedBox(height: 10),
              Text(
                "Case ID: GHO-2024-9481",
                style: AppFonts.subheading16.copyWith(fontSize: 14),
              ),
              SizedBox(height: 10),
              Text(
                "Patient: John Doe",
                style: AppFonts.subheading16.copyWith(fontSize: 14),
              ),
              SizedBox(height: 10),
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
                    "Oct 13, 2025",
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
              SizedBox(height: 20),
              // ignore: avoid_unnecessary_containers
              Container(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.hint1color.withAlpha(15),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.hint2color,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: AppColors.primarycolor,
                              width: 2.0,
                            ),
                            insets: EdgeInsets.symmetric(horizontal: 1.0),
                          ),

                          labelColor: AppColors.primarycolor,
                          unselectedLabelColor: AppColors.textSecondary,
                          labelStyle: TextStyle(fontWeight: FontWeight.w600),
                          unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: [
                            Tab(text: 'Type Written Report'),
                            Tab(text: 'Attach / Record Audio'),
                          ],
                        ),
                      ),
                      Container(
                        constraints:  BoxConstraints(minHeight: 300),
                        child: Stack(
                          children: [
                            Visibility(
                              visible: _tabController.index == 0,
                              maintainState: true,
                              child:  Writtenreport(),
                            ),
                            Visibility(
                              visible: _tabController.index == 1,
                              maintainState: true,
                              child:  Recordaudio(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CustomButton(
                          text: "Review & Confirm Submission",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
