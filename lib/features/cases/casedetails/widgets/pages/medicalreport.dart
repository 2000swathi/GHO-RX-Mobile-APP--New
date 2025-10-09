import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class Medicalreport extends StatelessWidget {
 Medicalreport({super.key});

  final List<Map<String, dynamic>> reports =  [
    {
      'icon': Icons.image,
      'color': AppColors.primarycolor,
      'title': 'MRI Lumbar Spine',
      'subtitle': 'DICOM File',
    },
    {
      'icon': Icons.picture_as_pdf,
      'color':AppColors.warningred,
      'title': 'Nerve Conduction Study Report',
      'subtitle': 'PDF File',
    },
    {
      'icon': Icons.image,
      'color': AppColors.primarycolor,
      'title': 'HBA1c Lab Results',
      'subtitle': 'JPEG File',
    },
    {
      'icon': Icons.picture_as_pdf,
      'color': AppColors.warningred,
      'title': 'Initial Consultation Notes',
      'subtitle': 'PDF File',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
    margin:  EdgeInsets.all(1.0),
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
            offset:  Offset(0, 3), 
          ),
        ],
      ),
      child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
           children: [
             const Text(
                'Medical Documents',
                style: AppFonts.subheading16
              ),
              SizedBox(width: 7,),
               Container(
                    padding:  EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightgreen ,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('4 Files', style: AppFonts.textprimarygreen12,),
                  ),
           ]
         ),
           SizedBox(height: 15),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return Container(
                margin:  EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  // ignore: deprecated_member_use
                  border: Border.all(color: AppColors.primarycolor.withAlpha(5), width: 1),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: AppColors.textPrimary.withAlpha(5),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Icon(report['icon'] as IconData, color: report['color'] as Color),
                  title: Text(report['title'] as String, style: AppFonts.subheading16),
                  subtitle: Text(report['subtitle'] as String, style: AppFonts.hinttext2),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}