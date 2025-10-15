import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/license_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/license_model.dart';

class AddEditLicenseSheet {
  static void showSheet(
    BuildContext context,
    LicenseModel info,
    List<LicenseList> licList,
    bool? isEdit,
  ) {
    final bool editing = isEdit == true && info.data.isNotEmpty;
    final _formKey = GlobalKey<FormState>();
    // Prefill only when editing
    final TextEditingController lNumController = TextEditingController(
      text: editing ? info.data[0].licenseNumber : "",
    );

    final TextEditingController issueDateController = TextEditingController(
      text: editing ? info.data[0].issueDate : "",
    );

    final TextEditingController expDateController = TextEditingController(
      text: editing ? info.data[0].expiryDate : "",
    );

    final TextEditingController licenseTypeController = TextEditingController(
      text: editing ? info.data[0].licenseType : "",
    );

    String? selectedLicenseTypeID =
        editing ? info.data[0].licenseTypeID.toString() : null;

    CustomBottomSheet.show(
      context: context,
      heading: editing ? "Edit License" : "Add License",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: lNumController,
                    name: "License Number",
                    hintText: "Enter License Number",
                    validator:
                        (value) => Validation.field(
                          value,
                          fieldName: "License Number",
                        ),
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownFormField<String>(
                    name: "License Type",
                    hintText: "-Select License-",
                    value: selectedLicenseTypeID,
                    validator:
                        (value) =>
                            Validation.field(value, fieldName: "License Type"),
                    items:
                        licList
                            .map(
                              (c) => DropdownItem<String>(
                                value: c.licenseTypeID.toString(),
                                label: c.licenseTypeName,
                              ),
                            )
                            .toList(),
                    onChanged: (id) {
                      setState(() {
                        selectedLicenseTypeID = id;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: issueDateController,
                    name: "Issue Date",
                    hintText: "dd/mm/yyyy",
                    validator: Validation.validateDate,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: expDateController,
                    name: "Expiry Date",
                    hintText: "dd/mm/yyyy",
                    validator: Validation.validateDate,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ],
      actionButton: CustomButton(
        text: editing ? "Update License" : "Add License",
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final licenseNumber = lNumController.text.trim();
            final issueDate = issueDateController.text.trim();
            final expiryDate = expDateController.text.trim();
            final licenseType = licenseTypeController.text.trim();
          }
        },
      ),
    );
  }
}
