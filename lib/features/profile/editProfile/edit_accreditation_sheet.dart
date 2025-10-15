import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/accreditation_model.dart';

class AddEditAccrediationBottomSheet {
  static void showSheet(
    BuildContext context,
    AccreditationModel info,
    bool isEdit,
  ) {
    final TextEditingController revIDController = TextEditingController(
      text:
          isEdit && info != null && info.data.isNotEmpty
              ? info.data[0].reviewerId.toString()
              : "",
    );
    final TextEditingController accTypeController = TextEditingController(
      text:
          isEdit && info != null && info.data.isNotEmpty
              ? info.data[0].accreditationType
              : "",
    );
    final TextEditingController accBodyController = TextEditingController(
      text:
          isEdit && info != null && info.data.isNotEmpty
              ? info.data[0].accreditationBody
              : "",
    );
    final TextEditingController accNumController = TextEditingController(
      text:
          isEdit && info != null && info.data.isNotEmpty
              ? info.data[0].accreditationNumber
              : "",
    );

    CustomBottomSheet.show(
      context: context,
      heading: isEdit == true ? "Edit Accrediation" : "Add Accrediation",
      content: [
        CustomTextFormField(
          controller: revIDController,
          name: "Reviewer ID",
          hintText: "Enter Reviwer ID",
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          controller: accTypeController,
          name: "Accrediation Type",
          hintText: "Enter Accrediation Type",
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          controller: accBodyController,
          name: "Accrediation body",
          hintText: "----",
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          controller: accNumController,
          name: "Accrediation Number",
          hintText: "Accrediation Number",
        ),
        SizedBox(height: 10),
      ],
      actionButton: CustomButton(
        text: isEdit == true ? "Submit Request" : "Add Accrediation",
        onPressed: () {},
      ),
    );
  }
}
