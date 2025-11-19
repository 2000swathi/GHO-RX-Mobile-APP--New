import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/language/bloc/language_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/language/model/language_model.dart';

class AddeditLanguageSheet {
  static void showSheet(
    BuildContext context,
    List<ReviewerLanguage> info,
    //  ReviewerLanguage item,
    bool? isEdit, {
    required LanguageBloc languagebloc,
  }) {
    // final bool editing = isEdit == true && info.data.isNotEmpty;
    final bool editing = isEdit == true;
    final _formKey = GlobalKey<FormState>();
    // final TextEditingController idController = TextEditingController(text: isEdit ? item?.id ?? '': '', );
    // String? selectedLanguage = isEdit == true ? item.language : null;
    // String? selectedProficiency = isEdit == true ? item.proficiency : null;

    String? selectedLanguage = editing ? info[0].language : null;
    String? selectedProficiency = editing ? info[0].proficiency : null;
    CustomBottomSheet.show(
      context: context,
      heading: editing ? "Edit Language" : "Add Language",
      content: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomDropdownFormField<String>(
                name: "Language",
                hintText: "Select Language",
                value: selectedLanguage,
                items: [
                  DropdownItem(value: "english", label: "English"),
                  DropdownItem(value: "malayalam", label: "Malayalam"),
                  DropdownItem(value: "hindi", label: "Hindi"),
                  DropdownItem(value: "tamil", label: "Tamil"),
                  DropdownItem(value: "telugu", label: "Telugu"),
                ],
                onChanged: (val) {
                  selectedLanguage = val;
                  print("Selected language: $val");
                },
              ),

              const SizedBox(height: 10),
              CustomDropdownFormField(
                name: "Proficiency",
                hintText: "Select proficiency",
                value: selectedProficiency,
                items: [
                  DropdownItem(value: "beginner", label: "Beginner"),
                  DropdownItem(value: "intermediate", label: "Intermediate"),
                  DropdownItem(value: "professional", label: "Proffess'ional"),
                ],
                onChanged: (val) {
                  selectedProficiency = val;
                  print("Selected language: $val");
                },
              ),
            ],
          ),
        ),
      ],
      // actionButton: BlocBuilder<AddBloc, AddState>(
      //   builder: (context, state) {
      //     return BlocListener<AddBloc, AddState>(
      //       listener: (context, state) {
      //         if (state is AddSuccess) {
      //           Navigator.pop(context);
      //         }
      //       },
      //       child: CustomButton(
      //         text: editing ? "Update Language" : "Add Language",
      //         onPressed: () {
      //           if (_formKey.currentState?.validate() ?? false) {
      //             context.read<AddBloc>().add(
      //               AddLanguage(
      //                 language: selectedLanguage ?? "",
      //                 proficiency: selectedProficiency ?? "",
      //               ),
      //             );
      //           }
      //         },
      //       ),
      //     );
      //   },
      // ),
      actionButton: MultiBlocListener(
        listeners: [
          BlocListener<AddBloc, AddState>(
            listener: (context, state) {
              if (state is AddSuccess) {
                Navigator.pop(context);
                languagebloc.add(FetchLanguage());
                CustomScaffoldMessenger.showSuccessMessage(
                  context,
                  state.response["Data"][0][0]['msg'] ??
                      "Language Added Successfully",
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
                languagebloc.add(FetchLanguage());
                CustomScaffoldMessenger.showSuccessMessage(
                  context,
                  state.message ?? "Language Updated Successfully",
                );
              } else if (state is EditFailure) {
                CustomScaffoldMessenger.showErrorMessage(
                  context,
                  state.error ?? "Failed to update language",
                );
              }
            },
          ),
        ],
        child: BlocBuilder<AddBloc, AddState>(
          builder: (context, addState) {
            final bool isAddLoading = addState is AddLoading;
            return BlocBuilder<EditBloc, EditState>(
              builder: (context, editState) {
                final bool isEditLoading = editState is EditLoading;
                final bool isLoading = isAddLoading || isEditLoading;

                return CustomButton(
                  text: editing ? "Update Language" : "Add Language",
                  isLoading: isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (editing) {
                        context.read<EditBloc>().add(
                          EditLanguageEvent(
                            language: selectedLanguage ?? "",
                            id: info[0].id.toString(),
                            proficiency: selectedProficiency ?? "",
                          ),
                        );
                      } else {
                        context.read<AddBloc>().add(
                          AddLanguage(
                            language: selectedLanguage ?? "",
                            proficiency: selectedProficiency ?? "",
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
