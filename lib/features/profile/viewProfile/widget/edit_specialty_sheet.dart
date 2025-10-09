import 'package:flutter/material.dart';

import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_phone.dart';

import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/specialty_model.dart';

class EditSpecialtySheet {
  static void showSheet(BuildContext context, SpecialtyModel info) {
    final TextEditingController specialtyController = TextEditingController(
      text: info.data[0].specialty,
    );
    final TextEditingController cBoardController = TextEditingController(
      text: info.data[0].certifiedBoard,
    );
    final TextEditingController splTypeController = TextEditingController(
      text: info.data[0].specialtyType,
    );

    CustomBottomSheet.show(
      context: context,
      heading: "Edit Specialty",
      content: [
        CustomDropdownField(
          controller: specialtyController,
          label: "Specialty",
          dropdownPosition: "right",
          dropdownItems: [],
        ),
        SizedBox(height: 10),
        CustomDropdownField(
          controller: cBoardController,
          label: "certified Board",
          dropdownPosition: "right",
          dropdownItems: [],
        ),
        SizedBox(height: 10),
        CustomDropdownField(
          controller: splTypeController,
          label: "specialty Type",
          dropdownPosition: "right",
          dropdownItems: [],
        ),
        SizedBox(height: 10),
      ],
      actionButton: CustomButton(text: "Edit Request", onPressed: () {}),
    );
  }
}
