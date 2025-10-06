import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/case_appbar.dart';

class ProfileDr extends StatelessWidget {
  const ProfileDr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CaseAppBar(title: 'Cases',),
    );
  }
}