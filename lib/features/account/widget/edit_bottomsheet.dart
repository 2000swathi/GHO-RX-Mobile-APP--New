import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';

class EditPersonalInfo {
  void showSheet(
    BuildContext context) {
      CustomBottomSheet.show(
        context: context,
        heading: "Edit Personal Information",
        content: [
          CustomTextFormField(
            name: "First Name", 
            hintText: "hintText"
          )
        ]
      );
    }
}