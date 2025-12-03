import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/account/experience/repo/bloc/professinal_experince_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/experience/repo/model/experience_model.dart';

class AddEditExperienceSheet {
  static List<DropdownItem<Object>> generateYearItems() {
    final current = DateTime.now().year;
    return List.generate(current - 1980 + 1, (i) {
      final year = (current - i).toString();
      return DropdownItem<Object>(value: year, label: year);
    });
  }

  static Map<String, String?> parseMonthYear(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return {"month": null, "year": null};
    }

    if (dateString.contains(",")) {
      final parts = dateString.split(",");
      return {"month": parts[0].trim(), "year": parts[1].trim()};
    }

    if (dateString.contains("/")) {
      final parts = dateString.split("/");
      return {"month": parts[0].trim(), "year": parts[1].trim()};
    }

    return {"month": null, "year": null};
  }

  static void showSheet(
    BuildContext context,
    ProfessionalExperience? item,
    bool isEdit, {
    required ProfessinalExperinceBloc experienceBloc,
    required List months,
  }) {
    final formKey = GlobalKey<FormState>();


    final parsedFrom = parseMonthYear(item?.dateFrom);
    final parsedTo = parseMonthYear(item?.dateTo);

    String? selectedFromMonth = parsedFrom["month"];
    String? selectedToMonth = parsedTo["month"];

    if (isEdit) {
      final matchFrom = months.firstWhere(
        (m) => m["T"] == selectedFromMonth,
        orElse: () => null,
      );
      if (matchFrom != null) {
        selectedFromMonth = matchFrom["D"].toString();
      }

      final matchTo = months.firstWhere(
        (m) => m["T"] == selectedToMonth,
        orElse: () => null,
      );
      if (matchTo != null) {
        selectedToMonth = matchTo["D"].toString();
      }
    }

    final fromYearCtrl = TextEditingController(text: parsedFrom["year"] ?? "");
    final toYearCtrl = TextEditingController(text: parsedTo["year"] ?? "");

    final instCtrl = TextEditingController(
      text: isEdit ? item?.institution : "",
    );
    final desigCtrl = TextEditingController(
      text: isEdit ? item?.designation : "",
    );
    final commentsCtrl = TextEditingController(
      text: isEdit ? item?.comments : "",
    );

    final yearItems = generateYearItems();

    CustomBottomSheet.show(
      context: context,
      heading:
          isEdit
              ? "Edit Professional Experience"
              : "Add Professional Experience",

      content: [
        StatefulBuilder(
          builder: (context, setSate) {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    name: "Institute",
                    controller: instCtrl,
                    hintText: "Enter Institute Name",
                    validator:
                        (value) => Validation.addressValidator(
                          value,
                          fieldName: "Institute",
                        ),
                  ),

                  CustomTextFormField(
                    name: "Designation",
                    controller: desigCtrl,
                    hintText: "Enter Designation",
                    validator:
                        (value) => Validation.addressValidator(
                          value,
                          fieldName: "Designation",
                        ),
                  ),

                  CustomDropdownFormField(
                    name: "From Month",
                    hintText: "Select month",
                    value: selectedFromMonth,
                    items:
                        months
                            .map<DropdownItem<Object>>(
                              (m) => DropdownItem<Object>(
                                value: m["D"].toString(),
                                label: m["T"].toString(),
                              ),
                            )
                            .toList(),
                    onChanged: (val) {
                      setSate(() {
                        selectedFromMonth = val.toString();
                      });
                    },
                    validator:
                        (val) => Validation.validateFromMonthYear(
                          selectedFromMonth,
                          fromYearCtrl.text,
                        ),
                  ),

                  CustomDropdownFormField(
                    name: "From Year",
                    hintText: "Select year",
                    items: yearItems,
                    value: fromYearCtrl.text,
                    onChanged: (val) {
                      setSate(() {
                        fromYearCtrl.text = val.toString();
                      });
                    },
                    validator:
                        (val) => Validation.validateFromMonthYear(
                          selectedFromMonth,
                          fromYearCtrl.text,
                        ),
                  ),

                  CustomDropdownFormField(
                    name: "To Month",
                    hintText: "Select month",
                    value: selectedToMonth,
                    items:
                        months
                            .map<DropdownItem<Object>>(
                              (m) => DropdownItem<Object>(
                                value: m["D"].toString(),
                                label: m["T"].toString(),
                              ),
                            )
                            .toList(),
                    onChanged: (val) {
                      setSate(() {
                        selectedToMonth = val.toString();
                      });
                    },
                    validator:
                        (val) => Validation.validateToMonthYear(
                          selectedFromMonth,
                          fromYearCtrl.text,
                          selectedToMonth,
                          toYearCtrl.text,
                        ),
                  ),

                  CustomDropdownFormField(
                    name: "To Year",
                    hintText: "Select year",
                    items: yearItems,
                    value: toYearCtrl.text,
                    onChanged: (val) {
                      setSate(() {
                        toYearCtrl.text = val.toString();
                      });
                    },
                    validator:
                        (val) => Validation.validateToMonthYear(
                          selectedFromMonth,
                          fromYearCtrl.text,
                          selectedToMonth,
                          toYearCtrl.text,
                        ),
                  ),

                  CustomTextFormField(
                    name: "Comments",
                    controller: commentsCtrl,
                    hintText: "Enter Comments",
                  ),
                ],
              ),
            );
          },
        ),
      ],
      actionButton: BlocListener<
        ProfessinalExperinceBloc,
        ProfessinalExperinceState
      >(
        listener: (context, state) {
          if (state is ExpSuccess) {
            Navigator.pop(context);
            context.read<ProfessinalExperinceBloc>().add(FetchExperience());
          } else if (state is ExpError) {
            CustomScaffoldMessenger.showErrorMessage(context, state.message);
          }
        },
        child: BlocBuilder<ProfessinalExperinceBloc, ProfessinalExperinceState>(
          builder: (context, state) {
            final bool isLoading =
                state is ProfessinalExperinceAddLoading ||
                state is ProfessinalExperinceEditLoading;

            return CustomButton(
              text: isEdit ? "Update Experience" : "Add Experience",
              isLoading: isLoading,
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                if (isEdit) {
                  experienceBloc.add(
                    EditExperience(
                      id: item!.id.toString(),
                      institution: instCtrl.text,
                      designation: desigCtrl.text,
                      fromMonth: selectedFromMonth!,
                      fromYear: fromYearCtrl.text,
                      toMonth: selectedToMonth!,
                      toYear: toYearCtrl.text,
                      comments: commentsCtrl.text,
                    ),
                  );
                } else {
                  experienceBloc.add(
                    AddExperience(
                      institution: instCtrl.text,
                      designation: desigCtrl.text,
                      fromMonth: selectedFromMonth ?? "",
                      fromYear: fromYearCtrl.text,
                      toMonth: selectedToMonth ?? "",
                      toYear: toYearCtrl.text,
                      comments: commentsCtrl.text,
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
