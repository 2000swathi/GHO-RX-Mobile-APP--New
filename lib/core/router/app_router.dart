import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/authentication/otp_screen.dart';
import 'package:ghorx_mobile_app_new/features/authentication/repository/model/login_model.dart';
import 'package:ghorx_mobile_app_new/features/authentication/add_page.dart';
import 'package:ghorx_mobile_app_new/features/authentication/reset_password.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/casedetails.dart';
import 'package:ghorx_mobile_app_new/features/profile/dr_insurance.dart';
import 'package:ghorx_mobile_app_new/features/profile/dr_license.dart';
import 'package:ghorx_mobile_app_new/features/profile/dr_specialty.dart';
import 'package:ghorx_mobile_app_new/features/profile/personal_info.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_page.dart';
import 'package:ghorx_mobile_app_new/features/auth/otp_screen.dart';
import 'package:ghorx_mobile_app_new/features/home/home_page.dart';
import 'package:ghorx_mobile_app_new/features/profile/personal_information.dart';
import 'package:ghorx_mobile_app_new/features/auth/repository/model/login_model.dart';
import 'package:ghorx_mobile_app_new/features/auth/add_page.dart';
import 'package:ghorx_mobile_app_new/features/auth/reset_password.dart';
import 'package:ghorx_mobile_app_new/features/profile/accreditation&speciality.dart';
import 'package:ghorx_mobile_app_new/main_page.dart';
import '../../features/authentication/login_screen.dart';
import '../../features/splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String personalinformation = '/personalinformation';
  static const String accreditation = '/accreditation';
  static const String otp = '/otp';
  static const String reset = '/reset';
  static const String addPage = '/addPage';
  static const String personalinfo = '/personalinfo';
  static const String mainPage = '/mainpage';
  static const String personalInfo = '/personalInfo';
  static const String drSpecialty = '/drSpecialty';
  static const String drInsurance = '/drInsurance';
  static const String drLicense = '/drLicense';
  static const String casepage = '/case';
  static const String casedetails = '/casedetails';
  static const String homePage = '/homepage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case otp:
        final otpResponse = settings.arguments as OtpResponse;
        return MaterialPageRoute(
          builder: (_) => OtpScreen(otpResponse: otpResponse),
          settings: settings,
        );
      case addPage:
        return MaterialPageRoute(builder: (_) => AddPage());
      case reset:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case mainPage:
        return MaterialPageRoute(builder: (_) => MainPage());
      case personalInfo:
        return MaterialPageRoute(builder: (_) => PersonalInfoScreen());
      case drSpecialty:
        return MaterialPageRoute(builder: (_) => DrSpecialty());
      case drInsurance:
        return MaterialPageRoute(builder: (_) => DrInsurance());
      case drLicense:
        return MaterialPageRoute(builder: (_) => DrLicense());
      case casepage:
        return MaterialPageRoute(builder: (_) => CasesPage());
      case casedetails:
        return MaterialPageRoute(builder: (_) => CaseDetailsPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
