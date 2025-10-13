import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_phone.dart';

import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
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
            return Column(
              children: [
                CustomTextFormField(
                  controller: firstNameController,
                  name: "First Name",
                  hintText: "Enter your first name",
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: lastNameController,
                  name: "Last Name",
                  hintText: "Enter your last name",
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: dobController,
                  name: "Birth Date",
                  hintText: "Enter your date of birth",
                ),
                const SizedBox(height: 10),

                CustomDropdownFormField<String>(
                  name: "Country",
                  hintText: "-select Country-",
                  value: selectedCountryId,
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
                ),

                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: emailController,
                  name: "Email",
                  hintText: "Enter your email address",
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  controller: address1Controller,
                  name: "Address 1",
                  hintText: "Enter your residential address",
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  controller: address2Controller,
                  name: "Address 2",
                  hintText: "Enter your residential address",
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  controller: cityController,
                  name: "City",
                  hintText: "Enter your City ",
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  controller: stateController,
                  name: "State",
                  hintText: "Enter your state",
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  controller: zipcodeController,
                  name: "Zip Code",
                  hintText: "Enter your City ",
                ),
                SizedBox(height: 10),
              ],
            );
          },
        ),
      ],
      actionButton: CustomButton(text: "Submit Request", onPressed: () {}),
    );
  }
}
