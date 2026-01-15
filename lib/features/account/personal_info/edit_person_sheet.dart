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
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/bloc/pic_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/bloc/pic_event.dart';
import 'package:intl/intl.dart';

class EditProfileSheetWidget extends StatefulWidget {
  final PersonalInfoModel info;
  final List<Country> countries;

  const EditProfileSheetWidget({
    super.key,
    required this.info,
    required this.countries,
  });

  static void show(
    BuildContext context,
    PersonalInfoModel info,
    List<Country> countries,
  ) {
    CustomBottomSheet.show(
      context: context,
      heading: "Edit Personal Information",
      content: [EditProfileSheetWidget(info: info, countries: countries)],
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
  late TextEditingController workphoneController;
  late TextEditingController npiController;
  late TextEditingController nationalityController;

  bool approved = false;
  bool boardCertified = false;
  bool activePractice = false;
  bool activeTeaching = false;
  bool activePublishing = false;
  bool activeResearch = false;
  bool activeSurgeon = false;

  String? selectedCountryId;
  late String selectedCountryCode;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController(text: widget.info.firstName);
    lastNameController = TextEditingController(text: widget.info.lastName);
    emailController = TextEditingController(text: widget.info.email);

    phoneController = TextEditingController(
      text: _stripCountryCode(widget.info.phone),
    );
    workphoneController = TextEditingController(
      text: _stripCountryCode(widget.info.workPhone),
    );
    stateController = TextEditingController(text: widget.info.state);
    cityController = TextEditingController(text: widget.info.city);

    String formattedDob = widget.info.birthDate;
    if (widget.info.birthDate.isNotEmpty) {
      try {
        DateTime parsedDate;
        if (widget.info.birthDate.contains('/')) {
          parsedDate = DateFormat('dd/MM/yyyy').parse(widget.info.birthDate);
        } else {
          parsedDate = DateFormat('dd MMM yyyy').parse(widget.info.birthDate);
        }
        formattedDob = DateFormat('dd/MM/yyyy').format(parsedDate);
      } catch (e) {
        formattedDob = widget.info.birthDate;
      }
    }
    dobController = TextEditingController(text: formattedDob);
    address1Controller = TextEditingController(text: widget.info.address1);
    address2Controller = TextEditingController(text: widget.info.address2);
    zipcodeController = TextEditingController(text: widget.info.zipCode);
    npiController = TextEditingController(text: widget.info.npi);
    nationalityController = TextEditingController(
      text: widget.info.nationality,
    );
    approved = widget.info.approved == true;
    boardCertified = widget.info.boardCertified.toLowerCase() == "yes";
    activePractice = widget.info.activePractice.toLowerCase() == "yes";
    activeTeaching = widget.info.activeTeaching.toLowerCase() == "yes";
    activePublishing = widget.info.activePublishing.toLowerCase() == "yes";
    activeResearch = widget.info.activeResearch.toLowerCase() == "yes";
    activeSurgeon = widget.info.activeSurgeon.toLowerCase() == "yes";

    Country? matchedCountry;
    if (widget.info.countryID != 0) {
      try {
        matchedCountry = widget.countries.firstWhere(
          (c) => c.countryID == widget.info.countryID,
        );
      } catch (e) {
        matchedCountry = null;
      }
    }

    if (matchedCountry == null && widget.info.nationality.isNotEmpty) {
      try {
        matchedCountry = widget.countries.firstWhere(
          (c) =>
              c.countryName.toLowerCase() ==
              widget.info.nationality.toLowerCase(),
        );
      } catch (e) {
        matchedCountry = null;
      }
    }
    if (matchedCountry == null && widget.countries.isNotEmpty) {
      matchedCountry = widget.countries.first;
    }

    selectedCountryId = matchedCountry?.countryID.toString() ?? '0';
    selectedCountryCode = matchedCountry?.countryCode ?? '';
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
            name: "Nationality",
            hintText: "-Select Country-",
            value: selectedCountryId,
            validator: Validation.validateForCountry,
            items:
                widget.countries
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
                final country = widget.countries.firstWhere(
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
          CustomPhoneField(
            label: "Work Phone Number",
            controller: workphoneController,
            countryCode: selectedCountryCode,
            // validator: Validation.validatePhone,
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
          // const SizedBox(height: 10),
          // CustomTextFormField(
          //   controller: address2Controller,
          //   name: "Address 2",
          //   hintText: "Enter your residential address",
          //   validator: Validation.addressValidator,
          // ),
          // const SizedBox(height: 10),
          // CustomTextFormField(
          //   controller: cityController,
          //   name: "City",
          //   hintText: "Enter your city",
          //   validator: Validation.validateForCity,
          // ),
          // const SizedBox(height: 10),
          // CustomTextFormField(
          //   controller: stateController,
          //   name: "State",
          //   hintText: "Enter your state",
          //   validator: Validation.validateForState,
          // ),
          // const SizedBox(height: 10),
          // CustomTextFormField(
          //   controller: zipcodeController,
          //   name: "Zip Code",
          //   hintText: "Enter your zip code",
          //   validator: Validation.postalCodeValidator,
          //   keyboardType: TextInputType.number,
          // ),
          const SizedBox(height: 10),
          CustomTextFormField(
            controller: npiController,
            name: "NPI",
            hintText: "National Provider Identifier",
            keyboardType: TextInputType.number,
            validator: Validation.validateNPI,
          ),
          // SizedBox(height: 10),
          // CustomTextFormField(
          //   controller: nationalityController,
          //   name: "Nationality",
          //   hintText: "National Provider Identifier",
          //   // validator: Validation.valid,
          // ),
          SizedBox(height: 20),
          _buildCheckboxGrid(),
          SizedBox(height: 20),
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
        context,
        "Please fill all required fields",
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final dobFormatted = DateFormat(
        'MM/dd/yyyy',
      ).format(DateFormat('dd/MM/yyyy').parse(dobController.text));

      final data = {
        "FirstName": firstNameController.text,
        "LastName": lastNameController.text,
        "eMail": emailController.text,
        "Phone": phoneController.text,
        "WorkPhone": workphoneController.text,
        "NPI": npiController.text,
        "Nationality": int.parse(selectedCountryId!),
        "CountryID": int.parse(selectedCountryId!),
        "Address1": address1Controller.text,
        // "Address2": address2Controller.text,
        "DOB": dobFormatted,
        "Approved": approved ? 1 : 0,
        "BoardCertified": boardCertified ? 1 : 0,
        "ActivePractice": activePractice ? 1 : 0,
        "ActiveTeaching": activeTeaching ? 1 : 0,
        "ActivePublishing": activePublishing ? 1 : 0,
        "ActiveResearch": activeResearch ? 1 : 0,
        "ActiveSurgon": activeSurgeon ? 1 : 0,
      };

      final repo = ProfileInfoRepo();
      final response = await repo.editPersonalInfo(data);

      if (!mounted) return;

      if (response["Status"] == 1) {
        final msg =
            response["Data"]?[0]?[0]?["msg"] ?? "Profile updated successfully";
        CustomScaffoldMessenger.showSuccessMessage(context, msg);
        context.read<ProfileInfoBloc>().add(FetchPersonalInfo());
        context.read<PicBloc>().add(FetchPicEvent());
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

  Widget _buildCheckboxGrid() {
    final items = [
      ("Approved", approved, (v) => approved = v),
      ("Board Certified", boardCertified, (v) => boardCertified = v),
      ("Active Practice", activePractice, (v) => activePractice = v),
      ("Active Teaching", activeTeaching, (v) => activeTeaching = v),
      ("Active Publishing", activePublishing, (v) => activePublishing = v),
      ("Active Research", activeResearch, (v) => activeResearch = v),
      ("Active Surgeon", activeSurgeon, (v) => activeSurgeon = v),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, 
        childAspectRatio: 3.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 4,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(item.$1, style: const TextStyle(fontSize: 14)),
          value: item.$2,
          onChanged: (v) {
            setState(() => item.$3(v ?? false));
          },
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
        );
      },
    );
  }

  String _stripCountryCode(String phone) {
    if (phone.isEmpty) return phone;
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length > 10) {
      return cleaned.substring(cleaned.length - 10);
    }
    return cleaned;
  }
}
