import 'package:flutter/material.dart';

import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty_response_model.dart';

import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/specialty_model.dart';

class AddEditSpecialtySheet {
  static void showSheet(
    BuildContext context,
    SpecialtyModel info,
    List<SpecialtyList> splList,
    bool? isEdit
  ) {
  
    String? selectedSpecialtyID =
        isEdit ==true ? info.data[0].specialtyId.toString() : null;
    String? selectedCertifiedBoard =
       isEdit ==true  ? info.data[0].certifiedBoard : null;
    String? selectedSpecialtyType =isEdit ==true ? info.data[0].specialtyType : null;
    CustomBottomSheet.show(
      context: context,
      heading: isEdit ==true  ? "Edit Specialty" : "Add Specialty",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                CustomDropdownFormField(
                  name: "Specialty",
                  hintText: "-Select Specialty-",
                  items:
                      splList
                          .map(
                            (e) => DropdownItem<String>(
                              label: e.specialtyName,
                              value: e.specialtyID.toString(),
                            ),
                          )
                          .toList(),
                  value: selectedSpecialtyID,
                  onChanged: (id) {
                    setState(() {
                      selectedSpecialtyID = id;
                    });
                  },
                ),
                SizedBox(height: 10),
                CustomDropdownFormField(
                  name: "Certified Board",
                  hintText: "-Select Certified Board-",
                  items: [],
                  value: selectedCertifiedBoard,
                ),
                SizedBox(height: 10),
                CustomDropdownFormField(
                  name: "Specialty Type",
                  hintText: "-Select Specialty Type-",
                  items: [],
                  value: selectedSpecialtyType,
                ),
                SizedBox(height: 10),
              ],
            );
          },
        ),
      ],
      actionButton: CustomButton(
        text: isEdit ==true  ? "Submit Request" : "Add Specialty",
        onPressed: () {
          
        },
      ),
    );
  }
}
