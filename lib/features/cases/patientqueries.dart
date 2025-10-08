import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class Patientqueries extends StatelessWidget {
  const Patientqueries({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), 
          ),
        ],
      ),
      child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Text(
            'Patient Queries',
            style: AppFonts.subheading16
          ),
        ],
      ),
    );
  }
}