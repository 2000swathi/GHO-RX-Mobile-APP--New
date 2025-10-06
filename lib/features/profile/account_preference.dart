import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_appbar.dart';

class AccountPreferences extends StatelessWidget {
  const AccountPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Account Preferences", 
        subtitle: "subtitle", 
        currentStep: 4, 
        totalSteps: 5,
        ),
    );
  }
}