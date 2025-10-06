import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_appbar.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_dob.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_phone.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/widget/custom_cvfield.dart';
import 'package:ghorx_mobile_app_new/features/profile/widget/customradio_buttons.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    TextEditingController stateController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController controller = TextEditingController();
    String selectedGender = "Male";
    DateTime? dob;
    final _formKey = GlobalKey<FormState>();


    return Scaffold(
      appBar: CustomAppBar(
        title: "Personal Information",
        subtitle: "Next: Accreditation & Speciality",
        currentStep: 1,
        totalSteps: 5,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "All uploads must be authentic and legible for faster approval.",
                          style: AppFonts.subtext,
                          textAlign: TextAlign.center,
                          softWrap: false,
                          overflow: TextOverflow.visible,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          validator: Validation.validateFullName,
                          name: "Full Name",
                          hintText: "Enter your full name",
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          name: "Email",
                          hintText: "Enter your email address",
                          validator: Validation.validateEmail,
                        ),
                        const SizedBox(height: 20),
                        CustomDropdownField(
                          validator: Validation.validatePhone,
                          label: "Primary Mobile Number",
                          controller: phoneController,
                          isPhoneField: true,
                          dropdownPosition: "left",
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          validator: Validation.addressValidator,
                          name: "Address",
                          hintText: "Enter your residential address",
                        ),
                        const SizedBox(height: 20),
                        CustomDropdownField(
                          validator: Validation.validateForCountry,
                          label: "Country",
                          controller: countryController,
                          isPhoneField: false,
                          dropdownPosition: "right",
                        ),
                        const SizedBox(height: 20),
                        CustomDropdownField(
                          label: "State",
                          controller: stateController,
                          isPhoneField: false,
                          dropdownPosition: "right",
                        ),
                        const SizedBox(height: 20),
                        CustomDropdownField(
                          label: "City",
                          controller: cityController,
                          isPhoneField: false,
                          dropdownPosition: "right",
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          name: "Zip/Postal Code",
                          hintText: "Enter your zip code",
                        ),
                        const SizedBox(height: 20),
                        CustomDOBField(
                          label: "Date of Birth",
                          selectedDate: dob,
                          onDateSelected: (pickedDate) {},
                        ),
                        const SizedBox(height: 20),
                        CustomRadioField(
                          label: "Gender",
                          options: ["Male", "Female", "Other"],
                          selectedValue: selectedGender,
                          onChanged: (value) {
                            selectedGender = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomDropdownField(
                          label: "Alternate Mobile Number",
                          controller: controller,
                          isPhoneField: true,
                          dropdownPosition: "left",
                        ),
                        const SizedBox(height: 20),
                        CustomCVUpload(
                          label: "Upload CV",
                          onUploadPressed: () {},
                        ),
                        const SizedBox(height: 20),
                        CustomButton(text: "Save & Continue", onPressed: () {
                          if (_formKey.currentState!.validate()) {
                          print("pressed");
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
