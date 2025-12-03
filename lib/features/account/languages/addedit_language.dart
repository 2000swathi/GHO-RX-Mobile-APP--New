import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/features/account/languages/repo/bloc/language_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/languages/repo/model/language_model.dart';

class AddeditLanguageSheet {
  static void showSheet(
    BuildContext context,
    List<ReviewerLanguage> info,
    //  ReviewerLanguage item,
    bool? isEdit, {
    required LanguageBloc languagebloc,
  }) {
    final bool editing = isEdit == true;
    final _formKey = GlobalKey<FormState>();

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
                },
              ),
            ],
          ),
        ),
      ],
      actionButton: MultiBlocListener(
        listeners: [
          BlocListener<LanguageBloc, LanguageState>(
            listener: (context, state) {
              if (state is LangSuccess) {
                Navigator.pop(context);
                languagebloc.add(FetchLanguage());
                CustomScaffoldMessenger.showSuccessMessage(
                  context,
                  state.message,
                );
              } else if (state is LangError) {
                CustomScaffoldMessenger.showErrorMessage(
                  context,
                  state.message,
                );
              }
            },
          ),
        ],
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            final bool isLoading = state is LanguageaddLoading;

            return CustomButton(
              text: editing ? "Update Language" : "Add Language",
              isLoading: isLoading,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (editing) {
                    context.read<LanguageBloc>().add(
                      EditLanguageEvent(
                        language: selectedLanguage ?? "",
                        id: info[0].id.toString(),
                      ),
                    );
                  } else {
                    context.read<LanguageBloc>().add(
                      AddLanguage(language: selectedLanguage ?? ""),
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
