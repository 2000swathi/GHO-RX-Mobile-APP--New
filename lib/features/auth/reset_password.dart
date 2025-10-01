import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomLogo(),
        ],
      ),
    );
  }
}