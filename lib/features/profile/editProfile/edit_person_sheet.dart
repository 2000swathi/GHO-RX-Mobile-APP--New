// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_phone.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/date_input_formatter.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/repository/edit_repository.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/personalinfo_model.dart';
import 'package:intl/intl.dart';

class EditProfileSheet {
  static void showSheet(
    BuildContext context,
    PersonalInfoModel info,
    List<Country> countries,
  ) {
    final TextEditingController firstNameController = TextEditingController(
      text: info.firstName,
    );
    final TextEditingController lastNameController = TextEditingController(
      text: info.lastName,
    );
    final TextEditingController emailController = TextEditingController(
      text: info.email,
    );
    final TextEditingController phoneController = TextEditingController(
      text: info.phone,
    );
    final TextEditingController stateController = TextEditingController(
      text: info.state,
    );
    final TextEditingController cityController = TextEditingController(
      text: info.city,
    );
    final TextEditingController dobController = TextEditingController(
      text: info.birthDate,
    );
    final TextEditingController address1Controller = TextEditingController(
      text: info.address1,
    );
    final TextEditingController address2Controller = TextEditingController(
      text: info.address2,
    );
    final TextEditingController zipcodeController = TextEditingController(
      text: info.zipCode,
    );
    final formKey = GlobalKey<FormState>();

    String? selectedCountryId = info.countryID.toString();
    String selectedCountryCode =
        countries
            .firstWhere(
              (c) => c.countryID.toString() == selectedCountryId,
              orElse:
                  () =>
                      countries.isNotEmpty
                          ? countries.first
                          : Country(
                            countryID: 0,
                            countryName: '',
                            countryCode: '',
                          ),
            )
            .countryCode;

    bool isLoading = false;

    CustomBottomSheet.show(
      context: context,
      heading: "Edit Personal Information",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: firstNameController,
                    name: "First Name",
                    hintText: "Enter your first name",
                    validator: Validation.validateFirstName,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: lastNameController,
                    name: "Last Name",
                    hintText: "Enter your last name",
                    validator: Validation.validateSecondtName,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: dobController,
                    name: "Birth Date",
                    hintText: "DD/MM/YYYY",
                    keyboardType: TextInputType.number,
                    validator: Validation.validateDOB,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Ensure only digits are typed
                      DobInputFormatter(), // Apply the auto-formatting
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownFormField<String>(
                    name: "Country",
                    hintText: "-select Country-",
                    value: selectedCountryId,
                    validator: Validation.validateForCountry,
                    items:
                        countries
                            .map(
                              (c) => DropdownItem<String>(
                                value: c.countryID.toString(),
                                label: c.countryName,
                              ),
                            )
                            .toList(),
                    onChanged: (id) {
                      setState(() {
                        selectedCountryId = id;
                        final country = countries.firstWhere(
                          (c) => c.countryID.toString() == id,
                        );
                        selectedCountryCode = country.countryCode;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomPhoneField(
                    label: "Phone Number",
                    controller: phoneController,
                    countryCode: selectedCountryCode,
                    validator: Validation.validatePhone,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: emailController,
                    name: "Email",
                    hintText: "Enter your email address",
                    validator: Validation.validateEmail,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: address1Controller,
                    name: "Address 1",
                    hintText: "Enter your residential address",
                    validator: Validation.addressValidator,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: address2Controller,
                    name: "Address 2",
                    hintText: "Enter your residential address",
                    validator: Validation.addressValidator,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: cityController,
                    name: "City",
                    hintText: "Enter your city",
                    validator: Validation.validateForCity,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: stateController,
                    name: "State",
                    hintText: "Enter your state",
                    validator: Validation.validateForState,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: zipcodeController,
                    name: "Zip Code",
                    hintText: "Enter your zip code",
                    validator: Validation.postalCodeValidator,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ],
      actionButton: StatefulBuilder(
        builder: (context, setState) {
          return CustomButton(
            text: isLoading ? "Submitting..." : "Submit Request",
            isLoading: isLoading,
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                setState(() => isLoading = true);

                try {
                  final Map<String, dynamic> data = {
                    "FirstName": firstNameController.text,
                    "LastName": lastNameController.text,
                    "eMail": emailController.text,
                    "Phone": phoneController.text,
                    "CountryID": int.parse(selectedCountryId.toString()),
                    "State": stateController.text,
                    "City": cityController.text,
                    "Address1": address1Controller.text,
                    "Address2": address2Controller.text,
                    "ZipCode": zipcodeController.text,
                    "DOB": DateFormat('MM/dd/yyyy').format(
                      DateFormat('dd/MM/yyyy').parse(dobController.text),
                    ),
                  };

                  final repo = EditprofileRepository();
                  final response = await repo.editPersonalInfo(data);

                  if (response["Status"] == 1) {
                    final msg =
                        response["Data"]?[0]?[0]?["msg"] ??
                        "Profile updated successfully";
                    Navigator.pop(context);
                    CustomScaffoldMessenger.showSuccessMessage(context, msg);
                  } else {
                    final err = response["Info"] ?? "Something went wrong";
                    Navigator.pop(context);
                    CustomScaffoldMessenger.showErrorMessage(context, err);
                  }
                } catch (e) {
                  Navigator.pop(context);
                  CustomScaffoldMessenger.showErrorMessage(
                    context,
                    e.toString(),
                  );
                } finally {
                  setState(() => isLoading = false);
                }
              } else {
                CustomScaffoldMessenger.showErrorMessage(
                  context,
                  "Please fill all required fields",
                );
              }
            },
          );
        },
      ),
    );
  }
}