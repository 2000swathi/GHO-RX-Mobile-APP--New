import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/language_model.dart';

class AddeditLanguageSheet {
  static void showSheet(
    BuildContext context,
    LanguageModel info,
    bool? isEdit,
  ) {
    final bool editing = isEdit == true && info.data.isNotEmpty;
    final _formKey = GlobalKey<FormState>();
    final TextEditingController languageController = TextEditingController(
      text: editing ? info.data[0].language : "",
    );

    final TextEditingController proficiencyController = TextEditingController(
      text: editing ? info.data[0].proficiency : "",
    );
    String? selectedLanguage = editing ? info.data[0].language : null;
    String? selectedProficiency = editing ? info.data[0].proficiency : null;
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
      actionButton: BlocBuilder<AddBloc, AddState>(
        builder: (context, state) {
          return BlocListener<AddBloc, AddState>(
            listener: (context, state) {
              if (state is AddSuccess) {
                Navigator.pop(context);
                context.read<ListBloc>().add(FetchLanguageList());
              }
            },
            child: CustomButton(
              text: editing ? "Update Language" : "Add Language",
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.read<AddBloc>().add(
                    AddLanguage(
                      language: selectedLanguage ?? "",
                      proficiency: selectedProficiency ?? "",
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
