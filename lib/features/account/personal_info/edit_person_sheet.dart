import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_phone.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/date_input_formatter.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/bloc/profile_info_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/profile_info_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/model/personalinfo_model.dart';
import 'package:intl/intl.dart';

class EditProfileSheetWidget extends StatefulWidget {
  final PersonalInfoModel info;
  final List<Country> countries;

  const EditProfileSheetWidget({
    Key? key,
    required this.info,
    required this.countries,
  }) : super(key: key);

  static void show(BuildContext context, PersonalInfoModel info, List<Country> countries) {
    CustomBottomSheet.show(
      context: context,
      heading: "Edit Personal Information",
      content: [
        EditProfileSheetWidget(info: info, countries: countries),
      ],
    );
  }

  @override
  State<EditProfileSheetWidget> createState() => _EditProfileSheetWidgetState();
}

class _EditProfileSheetWidgetState extends State<EditProfileSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController stateController;
  late TextEditingController cityController;
  late TextEditingController dobController;
  late TextEditingController address1Controller;
  late TextEditingController address2Controller;
  late TextEditingController zipcodeController;

  String? selectedCountryId;
  late String selectedCountryCode;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController(text: widget.info.firstName);
    lastNameController = TextEditingController(text: widget.info.lastName);
    emailController = TextEditingController(text: widget.info.email);
    phoneController = TextEditingController(text: widget.info.phone);
    stateController = TextEditingController(text: widget.info.state);
    cityController = TextEditingController(text: widget.info.city);
    dobController = TextEditingController(text: widget.info.birthDate);
    address1Controller = TextEditingController(text: widget.info.address1);
    address2Controller = TextEditingController(text: widget.info.address2);
    zipcodeController = TextEditingController(text: widget.info.zipCode);

    selectedCountryId = widget.info.countryID.toString();
    selectedCountryCode = widget.countries
        .firstWhere(
          (c) => c.countryID.toString() == selectedCountryId,
          orElse: () =>
              widget.countries.isNotEmpty
                  ? widget.countries.first
                  : Country(countryID: 0, countryName: '', countryCode: ''),
        )
        .countryCode;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    stateController.dispose();
    cityController.dispose();
    dobController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    zipcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            hintText: "DD/MM/YYYY",
            keyboardType: TextInputType.number,
            validator: Validation.validateDOB,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              DobInputFormatter(),
            ],
          ),
          const SizedBox(height: 10),
          CustomDropdownFormField<String>(
            name: "Country",
            hintText: "-select Country-",
            value: selectedCountryId,
            validator: Validation.validateForCountry,
            items: widget.countries
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
                final country =
                    widget.countries.firstWhere((c) => c.countryID.toString() == id);
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
            keyboardType: TextInputType.emailAddress,
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
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Submit Request",
            isLoading: isLoading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      CustomScaffoldMessenger.showErrorMessage(
          context, "Please fill all required fields");
      return;
    }

    setState(() => isLoading = true);

    try {
      final dobFormatted = DateFormat('MM/dd/yyyy').format(
        DateFormat('dd/MM/yyyy').parse(dobController.text),
      );

      final data = {
        "FirstName": firstNameController.text,
        "LastName": lastNameController.text,
        "eMail": emailController.text,
        "Phone": phoneController.text,
        "CountryID": int.parse(selectedCountryId!),
        "State": stateController.text,
        "City": cityController.text,
        "Address1": address1Controller.text,
        "Address2": address2Controller.text,
        "ZipCode": zipcodeController.text,
        "DOB": dobFormatted,
      };

      final repo = ProfileInfoRepo();
      final response = await repo.editPersonalInfo(data);

      if (!mounted) return;

      if (response["Status"] == 1) {
        final msg = response["Data"]?[0]?[0]?["msg"] ?? "Profile updated successfully";
        CustomScaffoldMessenger.showSuccessMessage(context, msg);
        context.read<ProfileInfoBloc>().add(FetchPersonalInfo());
        Navigator.pop(context);
      } else {
        final err = response["Info"] ?? "Something went wrong";
        CustomScaffoldMessenger.showErrorMessage(context, err);
      }
    } catch (e) {
      if (!mounted) return;
      CustomScaffoldMessenger.showErrorMessage(context, e.toString());
    } finally {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }
}
