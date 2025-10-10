import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_phone.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/license_model.dart';

class EditLicenseSheet {
  static void showSheet(BuildContext context, LicenseModel info) {
    final TextEditingController lNumController = TextEditingController(
      text: info.data[0].licenseNumber,
    );
    final TextEditingController issueAuthController = TextEditingController(
      text: info.data[0].issuingAuthority,
    );
    final TextEditingController lTypeController = TextEditingController(
      text: info.data[0].licenseType,
    );
    final TextEditingController issueDateController = TextEditingController(
      text: info.data[0].issueDate,
    );
    final TextEditingController expDateController = TextEditingController(
      text: info.data[0].expiryDate,
    );

    CustomBottomSheet.show(
      context: context,
      heading: "Edit License",
      content: [
        CustomTextFormField(
          controller: lNumController,
          name: "License Number",
          hintText: "Enter Lisence Number",
        ),
        SizedBox(height: 10),
        CustomDropdownField(
          controller: issueAuthController,
          label: "Issuing Authority",
          dropdownPosition: "right",
          dropdownItems: [],
        ),
        SizedBox(height: 10),
        CustomDropdownField(
          controller: lTypeController,
          label: "License Type",
          dropdownPosition: "right",
          dropdownItems: [],
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          controller: issueDateController,
          name: "Issue Date",
          hintText: "dd/mm/yyyy",
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          controller: expDateController,
          name: "Exp Date",
          hintText: "dd/mm/yyyy",
        ),
        SizedBox(height: 10),
      ],
      actionButton:CustomButton(text: "Submit Request", onPressed: () {})
    );
  }
}
