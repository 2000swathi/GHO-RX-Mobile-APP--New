// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/specialty_model.dart';

class AddEditSpecialtySheet {
  static void showSheet(
    BuildContext context,
    Specialty? info,
    List<SpecialtyList> splList,
    bool isEdit,
  ) {
    final _formKey = GlobalKey<FormState>();
    final bool editing = isEdit && info != null;

    String? selectedSpecialtyID =
        editing ? info.specialtyId.toString() : null;
    String? selectedCertifiedBoard =
        editing ? info.certifiedBoard : null;
    String? selectedSpecialtyType =
        editing ? info.specialtyType : null;


    CustomBottomSheet.show(
      context: context,
      heading: editing ? "Edit Specialty" : "Add Specialty",
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
                    validator: (v) => Validation.field(v, fieldName: "Specialty"),
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
                    validator: (v) => Validation.field(v, fieldName: "Certified Board"),
                    value: selectedCertifiedBoard,
                    items: [
                      DropdownItem(
                          value: "Medical Council of I", label: "Medical Council of I"),
                      DropdownItem(
                          value: "Medical Council of II", label: "Medical Council of II"),
                      DropdownItem(
                          value: "Medical Council of III", label: "Medical Council of III"),
                    ],
                    onChanged: (p0) {
                      setState(() {
                        selectedCertifiedBoard = p0;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  CustomDropdownFormField<String>(
                    name: "Specialty Type", 
                    hintText: "-Select Specialty Type-",
                    validator: (v) => Validation.field(v, fieldName: "Specialty Type"),
                    items:  [
                      DropdownItem(value: "S", label: "S"),
                      DropdownItem(value: "M", label: "M"),
                      DropdownItem(value: "P", label: "P"),
                      DropdownItem(value: "D", label: "D"),
                    ],
                    onChanged: (p0) {
                      setState(() {
                        selectedSpecialtyType = p0;
                      });
                    },
                    value: selectedSpecialtyType,
                  ),
                  SizedBox(height: 10),
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
                context.read<ProfileBloc>().add(FetchSpecialty());
                CustomScaffoldMessenger.showSuccessMessage(context, state.message);
              } else if (state is AddError) {
                Navigator.pop(context);
                CustomScaffoldMessenger.showErrorMessage(context, state.message);
              }
            },
          ),
          BlocListener<EditBloc, EditState>(
            listener: (context, state) {
              if (state is EditSuccess) {
                Navigator.pop(context);
                context.read<ProfileBloc>().add(FetchSpecialty());
                CustomScaffoldMessenger.showSuccessMessage(context, state.message);
              } else if (state is EditFailure) {
                Navigator.pop(context);
                CustomScaffoldMessenger.showErrorMessage(context, state.error);
              }
            },
          ),
        ],
        child: BlocBuilder<AddBloc, AddState>(
          builder: (context, addState) {
            return BlocBuilder<EditBloc, EditState>(
              builder: (context, editState) {
                final isLoading =
                    addState is AddLoading || editState is EditLoading;
                return CustomButton(
                  isLoading: isLoading,
                  text: editing ? "Update Specialty" : "Add Specialty",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (editing) {
                        context.read<EditBloc>().add(EditSpecialtyEvent(
                              specialtyId: info.id.toString(),
                              specialty: selectedSpecialtyID!,
                              certifiedBoard: selectedCertifiedBoard!,
                              specialtyType: selectedSpecialtyType!,
                            ));
                      } else {
                        context.read<AddBloc>().add(AddSpecialty(
                              specialty: selectedSpecialtyID!,
                              certifiedBoard: selectedCertifiedBoard!,
                              specialtyType: selectedSpecialtyType!,
                            ));
                      }
                    }
                  },
                );
              }
            );
          },
        ),
      )
      );
  }
}
