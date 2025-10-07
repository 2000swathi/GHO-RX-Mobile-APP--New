import 'package:flutter/material.dart';

import 'package:ghorx_mobile_app_new/features/cases/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/profile/widget/profiledetails.dart';

class ProfileDr extends StatelessWidget {
  const ProfileDr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CaseAppBar(title: 'Profile'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProfileDetails(
              heading: "Personal Information",
              ontap: () {
                Navigator.pushNamed(context, "/personalInfo");
              },
            ),
            ProfileDetails(
              heading: "Specialty",
              ontap: () {
                Navigator.pushNamed(context, "/drSpecialty");
              },
            ),

            ProfileDetails(
              heading: "Insurance",
              ontap: () {
                Navigator.pushNamed(context, "/drInsurance");
              },
            ),
            ProfileDetails(
              heading: "License",
              ontap: () {
                Navigator.pushNamed(context, "/drLicense");
              },
            ),
          ],
        ),
      ),
    );
  }
}
