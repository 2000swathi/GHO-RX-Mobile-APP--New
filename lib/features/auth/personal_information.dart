import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_appbar.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_phone.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(
        title: "Personal Information",
        subtitle: "Next: Accreditation & Speciality", 
        currentStep: 1, 
        totalSteps: 5,
      ),
      body: 
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("All uploads must be authentic and legible for faster approval.",
            style: AppFonts.subtext,
            textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              name: "Full Name",
              hintText: "Enter your full name"),
            SizedBox(height: 20),
            CustomTextFormField(
              name: "Email",
              hintText: "Enter your email address"),
            SizedBox(height: 20),
            CustomPhoneField(controller: phoneController),
            SizedBox(height: 20),
            CustomTextFormField(
              name: "Address",
              hintText: "Enter your residential address"),
            SizedBox(height: 20),
            CustomTextFormField(
              name: "Country",
              hintText: "Enter your city"),
            SizedBox(height: 20),
            
          ],
        ),
      
    );
  }
}