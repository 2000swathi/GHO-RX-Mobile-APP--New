import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/Summery.dart';
import 'package:ghorx_mobile_app_new/features/cases/medicalreport.dart';
import 'package:ghorx_mobile_app_new/features/cases/medications.dart';
import 'package:ghorx_mobile_app_new/features/cases/patientqueries.dart';

class TabItem {
  final String label;
  final IconData icon;
  final TextStyle? style;
  // final Color color;

  TabItem({
    required this.label, 
  required this.icon,
   this.style,
  //  required this.color,
   });
}

class AppointmentNavController extends GetxController {
  RxString selectedTab = 'Summary'.obs;

  final List<TabItem> appointmentTabs = [
    TabItem(
      label: 'Summary',
      icon: Icons.list_alt,
     style: AppFonts.buttontxt16,
    ),
    TabItem(
      label: 'Questions',
      icon: Icons.question_answer_outlined,
      // color: AppColors.skyBlueColor,
      style: AppFonts.buttontxt16,
    ),
    TabItem(
      label: 'Medical Report',
      icon: Icons.medical_services_outlined,
      // color: AppColors.skyBlueColor,
      style: AppFonts.buttontxt16,
    ),
    TabItem(
      label: 'Medications',
      icon: Icons.medication_outlined,
      // color: AppColors.skyBlueColor,
      style: AppFonts.buttontxt16,
    ),
  ];
  void changeTab(String label) {
    selectedTab.value = label;
  }
   Widget getSelectedAppointmentScreen() {
    switch (selectedTab.value) {
      case 'Summary':
        return Summerypage();
      case 'Questions':
        return Patientqueries();
      case 'Medical Report':
        return Medicalreport();
      case 'Medications':
        return Medications();
      default:
        return SizedBox(); // fallback
    }
  }
}
