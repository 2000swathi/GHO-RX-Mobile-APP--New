import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/account/education/repo/bloc/education_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/education/repo/model/educationmodel.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/education_typemodel.dart';

class AddeditEducationBottomSheet {
  static void showSheet(
    BuildContext context,
    EducationData? info,
    bool isEdit, {
    required EducationBloc educationBloc,
    required List<List<EducationTypeItem>> educationList,
  }) {
    final flattenedList = educationList.expand((e) => e).toList();
    final _formKey = GlobalKey<FormState>();

    String? degreeID = isEdit ? info?.degree : null;

    final instController = TextEditingController(
      text: isEdit ? info?.institution ?? '' : '',
    );
    final durationController = TextEditingController(
      text: isEdit ? info?.duration ?? '' : '',
    );
    final yearController = TextEditingController(
      text:
          isEdit && info?.completedYear != null
              ? info!.completedYear.toString()
              : '',
    );
    final commentsController = TextEditingController(
      text: isEdit ? info?.comments ?? '' : '',
    );

    CustomBottomSheet.show(
      context: context,
      heading: isEdit ? "Edit Education" : "Add Education",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    name: "Institute",
                    hintText: "Enter Institute",
                    controller: instController,
                    validator: Validation.validateProviderName,
                  ),
                  const SizedBox(height: 20),

                  // FIX 2: Dropdown using EducationData
                  CustomDropdownFormField(
                    name: "Degree",
                    hintText: " -Choose Your Degree- ",

                    // FIX 1: Pass degreeID to dropdown
                    value: degreeID,

                    items:
                        flattenedList
                            .map(
                              (e) => DropdownItem(
                                value: e.dataValue,
                                label:
                                    (e.displayText == null ||
                                            e.displayText!.trim().isEmpty)
                                        ? e.dataValue
                                        : e.displayText!,
                              ),
                            )
                            .toList(),

                    // FIX 2: UPDATE degreeID on selection
                    onChanged: (value) {
                      setState(() => degreeID = value);
                    },
                  ),

                  const SizedBox(height: 20),
                  CustomTextFormField(
                    name: "Duration",
                    hintText: "Enter Duration",
                    validator: Validation.validateProviderName,
                    controller: durationController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    name: "Year",
                    hintText: "Enter Year",
                    controller: yearController,
                    validator: Validation.validateProviderName,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    name: "Comments",
                    hintText: "Enter Comments",
                    validator: Validation.validateProviderName,
                    controller: commentsController,
                  ),
                ],
              ),
            );
          },
        ),
      ],
      actionButton: BlocListener<EducationBloc, EducationState>(
        listener: (context, state) {
          if (state is EduSuccess) {
            Navigator.pop(context);
            educationBloc.add(FetchEducation());
            CustomScaffoldMessenger.showSuccessMessage(context, state.message);
          } else if (state is EducationError) {
            CustomScaffoldMessenger.showErrorMessage(context, state.message);
          }
        },
        child: BlocBuilder<EducationBloc, EducationState>(
          builder: (context, state) {
            final bool isLoading =
                state is EducationAddLoading || state is EducationEditLoading;

            return CustomButton(
              text: isEdit ? "Update Education" : "Add Education",
              isLoading: isLoading,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (isEdit) {
                    educationBloc.add(
                      EditEducation(
                        id: info!.id.toString(),
                        institution: instController.text,
                        degree: degreeID ?? '',
                        duration: durationController.text,
                        year: yearController.text,
                        comments: commentsController.text,
                      ),
                    );
                  } else {
                    educationBloc.add(
                      AddEducation(
                        institution: instController.text,
                        degree: degreeID ?? '',
                        duration: durationController.text,
                        year: yearController.text,
                        comments: commentsController.text,
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
