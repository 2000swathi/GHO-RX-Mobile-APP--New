import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_phone.dart';

import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';

import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/personalinfo_model.dart';

class EditProfileSheet {
  static void showSheet(BuildContext context, PersonalInfoModel info) {
    final TextEditingController firstNameController = TextEditingController(
      text: info.firstName,
    );
    final TextEditingController lastNameController = TextEditingController(
      text: info.lastName,
    );
    final TextEditingController emailController = TextEditingController(
      text: info.email,
    );
    final TextEditingController phoneController = TextEditingController(
      text: info.phone,
    );
    final TextEditingController stateController = TextEditingController(
      text: info.state,
    );
    final TextEditingController countryController = TextEditingController(
      text: info.countryName,
    );
    final TextEditingController cityController = TextEditingController(
      text: info.city,
    );
    final TextEditingController dobController = TextEditingController(
      text: info.birthDate,
    );
    final TextEditingController address1Controller = TextEditingController(
      text: info.address1,
    );
    final TextEditingController address2Controller = TextEditingController(
      text: info.address2,
    );
    final TextEditingController zipcodeController = TextEditingController(
      text: info.zipCode,
    );
    CustomBottomSheet.show(
      context: context,
      heading: "Edit Personal Informations",
      content: [
        CustomTextFormField(
          controller: firstNameController,
          name: "First Name",
          hintText: "Enter your first name",
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: lastNameController,
          name: "Last Name",
          hintText: "Enter your last name",
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: dobController,
          name: "Birth Date",
          hintText: "Enter your date of birth",
        ),
        const SizedBox(height: 10),
        CustomDropdownField(isPhoneField: true, controller: phoneController),
        const SizedBox(height: 10),
        CustomDropdownField(
          controller: countryController,
          label: "Country",
          dropdownPosition: "right",
          dropdownItems: ["India", "USA", "Australia"],
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          controller: emailController,
          name: "Email",
          hintText: "Enter your email address",
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          controller: address1Controller,
          name: "Address 1",
          hintText: "Enter your residential address",
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          controller: address2Controller,
          name: "Address 2",
          hintText: "Enter your residential address",
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          controller: cityController,
          name: "City",
          hintText: "Enter your City ",
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          controller: stateController,
          name: "State",
          hintText: "Enter your state",
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          controller: zipcodeController,
          name: "Zip Code",
          hintText: "Enter your City ",
        ),
        SizedBox(height: 10),
      ],
      actionButton: Row(
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset("assets/svg/trash.svg")),
          Expanded(
            flex: 4,
            child: CustomButton(text: "Edit Request", onPressed: () {})),
        ],
      ),
    );
  }
}
