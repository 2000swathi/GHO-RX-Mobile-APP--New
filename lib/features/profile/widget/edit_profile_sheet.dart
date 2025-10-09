import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_phone.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class EditProfileSheet {
  static void showSheet(BuildContext context) {
    final TextEditingController countryController = TextEditingController();
    final TextEditingController stateController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 10),
                    Text(
                      "Edit Personal Informations",
                      style: AppFonts.semiratechart,
                    ),
                    SizedBox(width: 135.w),
                    Icon(Icons.close),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),

                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Divider(color: Color(0xffE7E9EF), thickness: 1),
                      CustomTextFormField(
                        name: "Full name",
                        hintText: "Enter your full name",
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        name: "Email",
                        hintText: "Enter your email address",
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        name: "Primary Mobile Number",
                        hintText: "XXXXX XXXXX",
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        name: "Address",
                        hintText: "Enter your residential address",
                      ),
                      SizedBox(height: 10),
                      CustomDropdownField(
                        controller: countryController,
                        label: "Country",
                        dropdownPosition: "right",
                        dropdownItems: ["India", "USA", "Australia"],
                      ),
                      SizedBox(height: 10),
                      CustomDropdownField(
                        controller: stateController,
                        label: "State",
                        dropdownPosition: "right",
                        dropdownItems: ["Kerala", "Delhi", "Mumbai"],
                      ),
                      SizedBox(height: 10),
                      CustomDropdownField(
                        controller: stateController,
                        label: "City",
                        dropdownPosition: "right",
                        dropdownItems: ["Kochi", "Trivandrum", "Calicut"],
                      ),
                      SizedBox(height: 10),
                      CustomButton(text: "Edit Request", onPressed: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
