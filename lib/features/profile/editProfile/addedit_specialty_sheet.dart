import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/specialty_model.dart';

class AddEditSpecialtySheet {
  static void showSheet(
    BuildContext context,
    SpecialtyModel info,
    List<SpecialtyList> splList,
    bool? isEdit,
  ) {
    final _formKey = GlobalKey<FormState>();
    String? selectedSpecialtyID =
        isEdit == true ? info.data[0].specialtyId.toString() : null;
    String? selectedCertifiedBoard =
        isEdit == true ? info.data[0].certifiedBoard : null;
    String? selectedSpecialtyType =
        isEdit == true ? info.data[0].specialtyType : null;
    CustomBottomSheet.show(
      context: context,
      heading: isEdit == true ? "Edit Specialty" : "Add Specialty",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomDropdownFormField(
                    name: "Specialty",
                    hintText: "-Select Specialty-",
                    validator: Validation.validateSpecialty,
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
                  CustomDropdownFormField<String>(
                    name: "Certified Board",
                    hintText: "-Select Certified Board-",
                    items: [],
                    value: selectedCertifiedBoard,
                    // validator: Validation.validateCertifiedBoard,
                  ),
                  SizedBox(height: 10),
                  CustomDropdownFormField<String>(
                    name: "Specialty Type", 
                    hintText: "-Select Specialty Type-",
                    items: [],
                    value: selectedSpecialtyType,
                    // validator: Validation.validateSpecialtyType,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ],
      actionButton: BlocBuilder<AddBloc, AddState>(
        builder: (context, state) {
          return CustomButton(
            text: isEdit == true ? "Submit Request" : "Add Specialty",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<AddBloc>().add(
                  AddSpecialty(
                    specialty: selectedSpecialtyID ?? '',
                    certifiedBoard: selectedCertifiedBoard ?? '',
                    specialtyType: selectedSpecialtyType ?? '',
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
