import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_phone.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/personalinfo_model.dart';

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
    final _formKey = GlobalKey<FormState>();

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

    CustomBottomSheet.show(
      context: context,
      heading: "Edit Personal Informations",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: _formKey,
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
                    hintText: "Enter your date of birth",
                    validator: Validation.validateDOB,
                  ),
                  const SizedBox(height: 10),
              
                  CustomDropdownFormField<String>(
                    name: "Country",
                    hintText: "-select Country-",
                    value: selectedCountryId,
                    validator: Validation.validateForCountry,
                    items:
                        countries.map((c) {
                          return DropdownItem<String>(
                            value: c.countryID.toString(),
                            label: c.countryName,
                          );
                        }).toList(),
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
              
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
                  CustomTextFormField(
                    controller: address1Controller,
                    name: "Address 1",
                    hintText: "Enter your residential address",
                    validator: Validation.addressValidator,
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    controller: address2Controller,
                    name: "Address 2",
                    hintText: "Enter your residential address",
                    validator: Validation.addressValidator,
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    controller: cityController,
                    name: "City",
                    hintText: "Enter your City ",
                    validator: Validation.validateForCity,
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    controller: stateController,
                    name: "State",
                    hintText: "Enter your state",
                    validator: Validation.validateForState,
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    controller: zipcodeController,
                    name: "Zip Code",
                    hintText: "Enter your City ",
                    validator: Validation.postalCodeValidator,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ],
      actionButton: CustomButton(text: "Submit Request", onPressed: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Success")),
            );
          // Navigator.pop(context);
        }else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Fill all the fields")),
          );
        }
      }),
    );
  }
}
