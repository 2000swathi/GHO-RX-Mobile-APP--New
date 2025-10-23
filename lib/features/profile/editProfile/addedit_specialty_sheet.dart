import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/specialty_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty_response_model.dart';

class AddEditSpecialtySheet {
  static void showSheet(
    BuildContext context,
    Specialty? info,
    List<SpecialtyList> splList,
    bool isEdit,
  ) {
    final formKey = GlobalKey<FormState>();
    String? selectedSpecialtyID = isEdit ? info?.specialtyId.toString() : null;
    String? selectedCertifiedBoard = isEdit ? info?.certifiedBoard : null;
    String? selectedSpecialtyType = isEdit ? info?.specialtyType : null;

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
                    items: splList
                        .map(
                          (e) => DropdownItem<String>(
                            label: e.specialtyName,
                            value: e.specialtyID.toString(),
                          ),
                        )
                        .toList(),
                    value: selectedSpecialtyID,
                    onChanged: (id) => setState(() {
                      selectedSpecialtyID = id;
                    }),
                  ),
                  const SizedBox(height: 10),

                  // Certified Board Dropdown
                  CustomDropdownFormField<String>(
                    name: "Certified Board",
                    hintText: "-Select Certified Board-",
                    items:  [
                      DropdownItem(
                          value: "Medical Council of I",
                          label: "Medical Council of I"),
                      DropdownItem(
                          value: "Medical Council of II",
                          label: "Medical Council of II"),
                      DropdownItem(
                          value: "Medical Council of III",
                          label: "Medical Council of III"),
                    ],
                    value: selectedCertifiedBoard,
                    onChanged: (value) =>
                        setState(() => selectedCertifiedBoard = value),
                    validator: Validation.validateCertifiedBoard,
                  ),
                  const SizedBox(height: 10),

         
                  CustomDropdownFormField<String>(
                    name: "Specialty Type",
                    hintText: "-Select Specialty Type-",
                    items:  [
                      DropdownItem(value: "S", label: "S"),
                      DropdownItem(value: "M", label: "M"),
                      DropdownItem(value: "P", label: "P"),
                      DropdownItem(value: "D", label: "D"),
                    ],
                    value: selectedSpecialtyType,
                    onChanged: (value) =>
                        setState(() => selectedSpecialtyType = value),
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
          // ADD listener
          BlocListener<AddBloc, AddState>(
            listener: (context, state) {
              if (state is AddSuccess) {
                Navigator.pop(context); // Close bottomsheet
                context.read<ProfileBloc>().add(FetchSpecialty());

                final msg = state.response["Data"]?[0]?[0]?["msg"] ??
                    "Specialty added successfully";

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(msg)),
                );
              } else if (state is AddError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),

         
          BlocListener<EditBloc, EditState>(
            listener: (context, state) {
              if (state is EditSuccess) {
                Navigator.pop(context);
                context.read<ProfileBloc>().add(FetchSpecialty());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is EditFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
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
                  text: isEdit
                      ? (isLoading ? "Updating..." : "Update Specialty")
                      : (isLoading ? "Adding..." : "Add Specialty"),
                  isLoading: isLoading, 
                  onPressed :() {
                          if (formKey.currentState!.validate()) {
                            if (isEdit) {
                              context.read<EditBloc>().add(
                                    EditSpecialtyEvent(
                                      specialtyId: info!.id.toString(),
                                      certifiedBoard:
                                          selectedCertifiedBoard ?? '',
                                      specialtyType:
                                          selectedSpecialtyType ?? '',
                                    ),
                                  );
                            } else {
                              context.read<AddBloc>().add(
                                    AddSpecialty(
                                      specialty: selectedSpecialtyID ?? '',
                                      certifiedBoard:
                                          selectedCertifiedBoard ?? '',
                                      specialtyType:
                                          selectedSpecialtyType ?? '',
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
