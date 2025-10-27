import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/certified_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty%20type_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/specialty_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty_response_model.dart';

class AddEditSpecialtySheet {
  static void showSheet(
    BuildContext context,
    Specialty? info,
    List<SpecialtyList> splList,
    List<CertifiedList> certList,
    List<SpecialtytypeList> specList,
    bool isEdit, {
    required ProfileBloc profileBloc,
  }) {
    final formKey = GlobalKey<FormState>();
    String? selectedSpecialtyID = isEdit ? info?.specialtyId.toString() : null;
    String? selectedCertifiedBoard;
    if (isEdit && info?.certifiedBoard != null) {
      try {
        selectedCertifiedBoard = certList
            .firstWhere((e) => e.certifiedName == info!.certifiedBoard)
            .certifiedID
            .toString();
      } catch (e) {
        selectedCertifiedBoard = null;
      }
    }
    String? selectedSpecialtyType;
    if (isEdit && info?.specialtyType != null) {
      try {
        selectedSpecialtyType = specList
            .firstWhere((e) => e.specialtytypeName == info!.specialtyType)
            .specialtytypeID
            .toString();
      } catch (e) {
        selectedSpecialtyType = null;
      }
    }

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
                  const SizedBox(height: 10),

                  // Certified Board Dropdown
                  CustomDropdownFormField<String>(
                    name: "Certified Board",
                    hintText: "-Select Certified Board-",
                    items:
                        certList
                            .map(
                              (e) => DropdownItem<String>(
                                label: e.certifiedName,
                                value: e.certifiedID.toString(),
                              ),
                            )
                            .toList(),
                    value: selectedCertifiedBoard,
                    onChanged: (id) {
                      setState(() {
                        selectedCertifiedBoard = id;
                      });
                    },
                    validator: Validation.validateCertifiedBoard,
                  ),

                  const SizedBox(height: 10),

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
                    value:selectedSpecialtyType,
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
      actionButton: MultiBlocListener(
        listeners: [
          BlocListener<AddBloc, AddState>(
            listener: (context, state) {
              if (state is AddSuccess) {
                Navigator.pop(context);
                profileBloc.add(FetchSpecialty());
                CustomScaffoldMessenger.showSuccessMessage(
                  context,
                  state.response["Data"][0][0]['msg'],
                );
              } else if (state is AddError) {
                CustomScaffoldMessenger.showErrorMessage(
                  context,
                  state.message,
                );
              }
            },
          ),
          BlocListener<EditBloc, EditState>(
            listener: (context, state) {
              if (state is EditSuccess) {
                Navigator.pop(context);
                profileBloc.add(FetchSpecialty());
                CustomScaffoldMessenger.showSuccessMessage(
                  context,
                  state.message ?? "Edited Successfully",
                );
              } else if (state is EditFailure) {
                CustomScaffoldMessenger.showErrorMessage(
                  context,
                  state.error ?? "Failed to edit",
                );
              }
            },
          ),
        ],

        child: BlocBuilder<AddBloc, AddState>(
          builder: (context, addState) {
            final isAddLoading = addState is AddLoading;

            return BlocBuilder<EditBloc, EditState>(
              builder: (context, editState) {
                final isEditLoading = editState is EditLoading;
                final isLoading = isAddLoading || isEditLoading;

                return CustomButton(
                  text:
                      isEdit
                          ? (isLoading ? "Updating..." : "Update Specialty")
                          : (isLoading ? "Adding..." : "Add Specialty"),
                  isLoading: isLoading,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (isEdit) {
                        String certifiedBoardName = '';
                        if (selectedCertifiedBoard != null) {
                          try {
                            certifiedBoardName = certList.firstWhere(
                              (b) => b.certifiedID.toString() == selectedCertifiedBoard
                            ).certifiedName;
                          } catch (e) {
                            // Handle case where ID is not found, though unlikely if dropdown is populated correctly
                          }
                        }
                        context.read<EditBloc>().add(
                          EditSpecialtyEvent(
                            id: info!.id.toString(),
                            specialtyId: selectedSpecialtyID ?? '',
                            certifiedBoard: selectedCertifiedBoard ?? '',
                            specialtyType: selectedSpecialtyType ?? '',
                          ),
                        );
                      } else {
                        context.read<AddBloc>().add(
                          AddSpecialty(
                            specialty: selectedSpecialtyID ?? '',
                            certifiedBoard: selectedCertifiedBoard ?? '',
                            specialtyType: selectedSpecialtyType ?? '',
                          ),
                        );
                      }
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
