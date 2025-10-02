import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_appbar.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_phone.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/auth/profile/widget/genderfield_widget.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final TextEditingController phoneController = TextEditingController();
  String selectedCode = "91";
  String selectedGender = "Male";
  final List<String> codes = ["91", "1", "44", "61"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Personal Information",
          subtitle: "Next: Accreditation & Speciality",
          currentStep: 1,
          totalSteps: 5,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                "All uploads must be authentic and legible for faster approval.",
                style: AppFonts.subtext,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                name: "Full Name",
                hintText: "Enter your full name",
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                name: "Email",
                hintText: "Enter your email address",
              ),
              const SizedBox(height: 20),

              CustomPhoneField(
                controller: phoneController,
                label: "Phone Number",
                selectedCountryCode: selectedCode,
                countryCodes: codes,
                onChanged: (val) {
                  setState(() {
                    selectedCode = val ?? "91";
                  });
                },
                onPhoneChanged: (val) {
                  print("Phone: $val");
                },
              ),

              const SizedBox(height: 20),
              CustomTextFormField(
                name: "Address",
                hintText: "Enter your residential address",
              ),
              const SizedBox(height: 20),

              CustomDropdownFormField<String>(
                name: "Country",
                hintText: "Select Country",
                items: ["India", "US", "China"],
                value: null,
                onChanged: (val) {
                  print("Selected: $val");
                },
                validator:
                    (val) => val == null ? "Please select your country" : null,
              ),

              const SizedBox(height: 20),

              CustomDropdownFormField<String>(
                name: "State",
                hintText: "Select State",
                items: ["Kerala", "Karnataka", "Thamilnadu"],
                value: null,
                onChanged: (val) {
                  print("Selected: $val");
                },
                validator:
                    (val) => val == null ? "Please select your state" : null,
              ),
              const SizedBox(height: 20),
              CustomDropdownFormField<String>(
                name: "City",
                hintText: "Select City",
                items: ["City1", "City2", "City3"],
                value: null,
                onChanged: (val) {
                  print("Selected: $val");
                },
                validator:
                    (val) => val == null ? "Please select your state" : null,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                name: "Zip/Postal Code",
                hintText: "Enter your zip code",
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                prefixIcon: Icon(
                  Icons.date_range_rounded,
                  color: AppColors.hint2color,
                ),
                name: "Date of Birth",
                hintText: "DD / MM / YYYY",
              ),
              const SizedBox(height: 20),
              GenderRadioButton(
                selectedGender: selectedGender,
                onChanged: (val) {
                  setState(() {
                    selectedGender = val ?? "Male";
                  });
                },
              ),
              const SizedBox(height: 20),

              CustomButton(
                text: "Save & Continue",
                onPressed: () {
                  print("Country Code: +$selectedCode");
                  print("Phone: ${phoneController.text}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
