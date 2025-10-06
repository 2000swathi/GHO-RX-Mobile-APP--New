import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_appbar.dart';

class Insurance extends StatelessWidget {
  const Insurance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Insurance", 
        subtitle: "Next: Account Preferences", 
        currentStep: 3, 
        totalSteps: 5,
        ),
    );
  }
}