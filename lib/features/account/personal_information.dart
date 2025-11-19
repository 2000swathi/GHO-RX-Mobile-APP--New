import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/edit_bottomsheet.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 24,
            color: AppColors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          "Personal Information",
          style: AppFonts.heading,
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () {
                EditPersonalInfo().showSheet(
                  context
                );
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/account/pencil.svg",
                    height: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Edit",
                    style: AppFonts.textblue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // PROFILE IMAGE
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.glasscontainer,
                    backgroundImage: const AssetImage(
                      "assets/images/default_user.png", 
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: SvgPicture.asset(
                      "assets/svg/account/Appointments.svg",
                      height: 36,
                      width: 36,
                    )
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // INFO FIELDS
              buildInfo("First Name", "John"),
              buildInfo("Last Name", "Doe"),
              buildInfo("Date of Birth", "15 / 08 / 1982"),
              buildInfo("Gender", "Male"),
              buildInfo("Email", "rohan.mehta@gmail.com"),
              buildInfo("Mobile Number", "+91 98765 43210"),
              buildInfo("Alternate Mobile Number", "+91 80976 16821"),
              buildInfo("Address", "23, Green View Apartments, Indiranagar"),
              buildInfo("Country", "India"),
              buildInfo("State", "Karnataka"),
              buildInfo("City", "Bengaluru"),
              buildInfo("Zip/Postal Code", "560038"),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================
  // REUSABLE INFO ROW WIDGET
  // ==============================

  Widget buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: AppFonts.hinttext2
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: AppFonts.textprimary
          ),
        ],
      ),
    );
  }
}
