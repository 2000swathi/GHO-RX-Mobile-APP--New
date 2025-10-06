import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_appbar.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class AccreditationSpl extends StatelessWidget {
  const AccreditationSpl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Accreditation & Speciality",
        subtitle: "Next: Insurance",
        currentStep: 2,
        totalSteps: 5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Column(
          children: [
            Text(
              "To ensure a faster review process, please provide accurate \nand verifiable information. All accreditations should be \ncurrent and officially documented.",
              style: AppFonts.subtext,
              textAlign: TextAlign.left,
              softWrap: false,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 20),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Additional Accreditations & Specialties",
                      style: AppFonts.subheading,
                      textAlign: TextAlign.left,
                    ),
        
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      name: "License /Certificate Number",
                      hintText: "e.g., A123456789",
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      name: "Issuing Authority/Certifying Body",
                      hintText: "e.g., American Board of Internal Medicine",
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      name: "Sub-Speciality/Speciality",
                      hintText: "e.g., Interventional Cardiology",
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      name: "Years in this role",
                      hintText: "e.g., 5",
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      
      ),
    );
  }
}
