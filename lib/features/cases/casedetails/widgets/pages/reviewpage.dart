import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/final_opinion_confirmation.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/pages/recordaudio.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/pages/writtenreport.dart';

class Reviewpage extends StatefulWidget {
  const Reviewpage({super.key});

  @override
  State<Reviewpage> createState() => _ReviewpageState();
}

class _ReviewpageState extends State<Reviewpage>
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
    return Container(
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
            constraints: BoxConstraints(minHeight: 300),
            child: Stack(
              children: [
                Visibility(
                  visible: _tabController.index == 0,
                  maintainState: true,
                  child: Writtenreport(),
                ),
                Visibility(
                  visible: _tabController.index == 1,
                  maintainState: true,
                  child: Recordaudio(),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: CustomButton(
              text: "Review & Confirm Submission",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FinalOpinionConfirmation(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}