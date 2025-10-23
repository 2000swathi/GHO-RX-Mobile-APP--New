import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
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

    CustomBottomSheet.show(
      context: context,
      heading: editing ? "Edit Language" : "Add Language",
      content: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: languageController,
                name: "Language",
                hintText: "Enter Language",
                validator:
                    (value) => Validation.field(value, fieldName: "Language"),
              ),

              const SizedBox(height: 10),
              CustomTextFormField(
                controller: proficiencyController,
                name: "Proficiency",
                hintText: "Enter Proficiency",
                validator:
                    (value) =>
                        Validation.field(value, fieldName: "Proficiency"),
              ),
            ],
          ),
        ),
      ],
      actionButton: CustomButton(
        text: editing ? "Update Language" : "Add Language",
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            languageController.text.trim();
          }
        },
      ),
    );
  }
}
