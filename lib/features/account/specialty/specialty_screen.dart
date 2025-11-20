import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class SpecialtyScreen extends StatelessWidget {
  const SpecialtyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAccountAppBar(
        title: "Specialty"
      ),
      );
  }
}