import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/insurance_model.dart';

class EditInsuranceSheet {
  static void showSheet(BuildContext context, InsuranceModel info) {
    final TextEditingController prIDController = TextEditingController(
      text: info.data[0].providerID,
    );
    final TextEditingController pNameController = TextEditingController(
      text: info.data[0].providerName,
    );
    final TextEditingController issueDateController = TextEditingController(
      text: info.data[0].issueDate,
    );
    final TextEditingController expDateController = TextEditingController(
      text: info.data[0].expiryDate,
    );

    CustomBottomSheet.show(
      context: context,
      heading: "Edit Specialty",
      content: [
        CustomTextFormField(
          controller: prIDController,
          name: "Provider ID",
          hintText: "Enter Provider ID",
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          controller: pNameController,
          name: "Provider Name",
          hintText: "Enter Provider name",
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
      actionButton: Row(
        children: [
          Expanded(flex: 1, child: SvgPicture.asset("assets/svg/trash.svg")),
          Expanded(
            flex: 4,
            child: CustomButton(text: "Edit Request", onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
