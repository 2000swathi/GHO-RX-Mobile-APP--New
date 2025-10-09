import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class PatientQueriesPopup {
  static void showSheet(BuildContext context, String queryText) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        return Container(
          height: screenHeight * 0.9,
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 10),
                  Text("Patient Queries",
                  style: AppFonts.subheading16,
                  ),
                  Spacer(),
                  IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  icon: Icon(Icons.close))             
                ]),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 5,
                      height: 50,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: AppColors.yellow,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                      queryText,
                      style: AppFonts.textprimary,
                      ),
                    )
                  ],
                )
            ]
          ),
        );
      }
    );
}
}