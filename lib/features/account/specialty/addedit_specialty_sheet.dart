import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/specialty%20type_response_model.dart';
import 'package:ghorx_mobile_app_new/features/account/specialty/repo/bloc/specialty_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/specialty/repo/model/specialty_model.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/specialty_response_model.dart';

class AddEditSpecialtySheet {
  static void showSheet(
    BuildContext context,
    Specialtym? info,
    List<SpecialtyList> splList,
    List<SpecialtytypeList> specList,
    bool isEdit, {
    required SpecialtyBloc specBloc,
  }) {
    final formKey = GlobalKey<FormState>();
    String? selectedSpecialtyID = isEdit ? info?.specialtyId.toString() : null;
    String? selectedSpecialtyType;
    if (isEdit && info?.specialtyType != null) {
      try {
        selectedSpecialtyType =
            specList
                .firstWhere((e) => e.specialtytypeName == info!.specialtyType)
                .specialtytypeID
                .toString();
      } catch (e) {
        selectedSpecialtyType = null;
      }
    }
    final TextEditingController certifiedBoardController =TextEditingController(text: isEdit?info?.certifiedBoard:"");


    CustomBottomSheet.show(
      context: context,
      heading: isEdit ? "Edit Specialty" : "Add Specialty",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  // Specialty Dropdown
                  CustomDropdownFormField<String>(
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
                    onChanged:
                        (id) => setState(() {
                          selectedSpecialtyID = id;
                        }),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: certifiedBoardController,
                    validator: Validation.validateSpecialtyBoard,
                    name: "Certified Board / Institution",
                    hintText: "enter Certified board / Institution",
                  ),
                  const SizedBox(height: 20),

                  CustomDropdownFormField<String>(
                    name: "Specialty Type",
                    hintText: "-Select Specialty Type-",
                    items:
                        specList
                            .map(
                              (e) => DropdownItem<String>(
                                label: e.specialtytypeName,
                                value: e.specialtytypeID.toString(),
                              ),
                            )
                            .toList(),
                    value: selectedSpecialtyType,
                    onChanged: (id) {
                      setState(() {
                        selectedSpecialtyType = id;
                      });
                    },
                    validator: Validation.validateSpecialtyType,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ],
      actionButton: BlocListener<SpecialtyBloc, SpecialtyState>(
        listener: (context, state) {
          if (state is SpecialtySuccess) {
            Navigator.pop(context);
            context.read<SpecialtyBloc>().add(FetchSpecialty());
            CustomScaffoldMessenger.showSuccessMessage(context, state.message);
          } else if (state is SpecialtyError) {
            CustomScaffoldMessenger.showErrorMessage(context, state.message);
          }
        },
        child: BlocBuilder<SpecialtyBloc, SpecialtyState>(
          builder: (context, state) {
            final isLoading =
                state is SpecialityAddLoading || state is SpecialityEditLoading;

            return CustomButton(
              text:
                  isEdit
                      ? (isLoading ? "Updating..." : "Update Specialty")
                      : (isLoading ? "Adding..." : "Add Specialty"),
              isLoading: isLoading,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (isEdit) {
                    context.read<SpecialtyBloc>().add(
                      EditSpecialtyEvent(
                        id: info!.id.toString(),
                        specialtyId: selectedSpecialtyID ?? '',
                        certifiedBoard: certifiedBoardController.text.trim(),
                        specialtyType: selectedSpecialtyType ?? '',
                      ),
                    );
                  } else {
                    context.read<SpecialtyBloc>().add(
                      AddSpecialty(
                        specialty: selectedSpecialtyID ?? '',
                        certifiedBoard: certifiedBoardController.text.trim(),
                        specialtyType: selectedSpecialtyType ?? '',
                      ),
                    );
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
