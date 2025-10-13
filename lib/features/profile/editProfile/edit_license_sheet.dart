import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_phone.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/license_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/license_model.dart';

class EditLicenseSheet {
  static void showSheet(
    BuildContext context,
    LicenseModel info,
    List<LicenseList> licList,
  ) {
    final TextEditingController lNumController = TextEditingController(
      text: info.data[0].licenseNumber,
    );

    final TextEditingController issueDateController = TextEditingController(
      text: info.data[0].issueDate,
    );
    final TextEditingController expDateController = TextEditingController(
      text: info.data[0].expiryDate,
    );
    String? selectedLicenseTypeID =
        info.data.isNotEmpty ? info.data[0].toString() : null;

    CustomBottomSheet.show(
      context: context,
      heading: "Edit License",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                CustomTextFormField(
                  controller: lNumController,
                  name: "License Number",
                  hintText: "Enter Lisence Number",
                ),
                SizedBox(height: 10),
                CustomDropdownFormField<String>(
                  name: "Licence Type",
                  hintText: "-select Licence-",
                  value: selectedLicenseTypeID,
                  items:
                      licList.map((c) {
                        return DropdownItem<String>(
                          value: c.licenseTypeID.toString(),
                          label: c.licenseTypeName,
                        );
                      }).toList(),
                  onChanged: (id) {
                    setState(() {
                      selectedLicenseTypeID = id;
                    });
                  },
                ),

                // ),
                // SizedBox(height: 10),
                // CustomPhoneDropdownField(
                //   controller: lTypeController,
                //   label: "License Type",

                // ),
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
            );
          },
        ),
      ],
      actionButton: CustomButton(text: "Submit Request", onPressed: () {}),
    );
  }
}
