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

    // Controllers
    final instController = TextEditingController(
      text: isEdit ? info?.institution ?? '' : '',
    );
    final durationController = TextEditingController(
      text: isEdit ? info?.duration ?? '' : '',
    );
    final yearController = TextEditingController(
      text:
          (isEdit && info?.completedYear != null)
              ? info!.completedYear.toString()
              : '',
    );
    final commentsController = TextEditingController(
      text: isEdit ? info?.comments ?? '' : '',
    );
    final otherDegreeController = TextEditingController();

    String? degreeID;
    if (isEdit && info?.degree != null && info!.degree!.isNotEmpty) {
      final saved = info.degree!;

      final matchByValue =
          flattenedList.where((e) => e.dataValue == saved).toList();
      if (matchByValue.isNotEmpty) {
        degreeID = matchByValue.first.dataValue;
      } else {
        final matchByDisplay =
            flattenedList.where((e) => (e.displayText ?? '') == saved).toList();
        if (matchByDisplay.isNotEmpty) {
          degreeID = matchByDisplay.first.dataValue;
        } else {
          degreeID = "Other";
          otherDegreeController.text = saved;
        }
      }
    } else {
      degreeID = null;
    }

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

                  CustomDropdownFormField(
                    name: "Degree",
                    hintText: " -Choose Your Degree- ",
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
                    onChanged: (value) {
                      setState(() {
                        degreeID = value;
                        if (value != "Other") {
                          otherDegreeController.clear();
                        }
                      });
                    },
                  ),

                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child:
                        degreeID == "Other"
                            ? Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: CustomTextFormField(
                                name: "Other",
                                hintText: "Enter your degree",
                                controller: otherDegreeController,
                                validator: Validation.validateProviderName,
                              ),
                            )
                            : const SizedBox.shrink(),
                  ),

                  const SizedBox(height: 20),

                  CustomTextFormField(
                    name: "Duration",
                    hintText: "Enter Duration",
                    controller: durationController,
                    validator: Validation.validateProviderName,
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
                    controller: commentsController,
                    validator: Validation.validateProviderName,
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
                  final String finalDegree =
                      degreeID == "Other"
                          ? otherDegreeController.text.trim()
                          : degreeID ?? "";

                  if (finalDegree.isEmpty) {
                    CustomScaffoldMessenger.showErrorMessage(
                      context,
                      "Please enter your degree",
                    );
                    return;
                  }

                  if (isEdit) {
                    educationBloc.add(
                      EditEducation(
                        id: info!.id.toString(),
                        institution: instController.text,
                        degree: finalDegree,
                        duration: durationController.text,
                        year: yearController.text,
                        comments: commentsController.text,
                      ),
                    );
                  } else {
                    educationBloc.add(
                      AddEducation(
                        institution: instController.text,
                        degree: finalDegree,
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
