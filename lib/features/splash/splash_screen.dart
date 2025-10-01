import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CustomLogo(isSplash: true)));
  }
}
