import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class Medicalreport extends StatelessWidget {
  Medicalreport({super.key});

  final List<Map<String, dynamic>> reports = [
    {
      'icon': "assets/svg/Files Icons.svg",
      'title': 'MRI Lumbar Spine',
      
    },
    {
      'icon': "assets/svg/pdfIcons.svg",
      'title': 'Nerve Conduction Study Report',
      
    },
    {
      'icon': "assets/svg/Files Icons.svg",
      'title': 'HBA1c Lab Results',
     
    },
    {
      'icon': "assets/svg/pdfIcons.svg",
      'title': 'Initial Consultation Notes',
      
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Notifier to track the expanded state, only used if items > 2
    final isExpanded = ValueNotifier<bool>(false);

    return Container(
      margin: EdgeInsets.all(1.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: AppColors.hint2color.withAlpha(1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Medical Documents",
                style: AppFonts.hinttext2.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 7),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.lightgreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('4 Files', style: AppFonts.textprimarygreen12),
              ),
            ],
          ),
          SizedBox(height: 10),
          if (reports.length <= 3)
            _buildReportList(reports.length)
          else
            ValueListenableBuilder<bool>(
              valueListenable: isExpanded,
              builder: (context, isExpandedValue, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildReportList(isExpandedValue ? reports.length : 3),
                 
                    GestureDetector(
                      onTap: () => isExpanded.value = !isExpanded.value,
                      child: Text(
                        isExpandedValue ? "Read less" : "Read more...",
                        style:  AppFonts.hinttext2,
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildReportList(int itemCount) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final report = reports[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primarycolor,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withAlpha(5),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: SvgPicture.asset(
              report['icon'] as String,
            ),
            title: Text(
              report['title'] as String,
              style: AppFonts.subheading16,
            ),
           
          ),
        );
      },
    );
  }
}
