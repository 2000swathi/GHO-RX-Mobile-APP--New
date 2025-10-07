import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/auth/otp_screen.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_page.dart';
import 'package:ghorx_mobile_app_new/features/profile/personal_information.dart';
import 'package:ghorx_mobile_app_new/features/auth/repository/model/login_model.dart';
import 'package:ghorx_mobile_app_new/features/auth/add_page.dart';
import 'package:ghorx_mobile_app_new/features/auth/reset_password.dart';
import 'package:ghorx_mobile_app_new/features/profile/accreditation&speciality.dart';
import 'package:ghorx_mobile_app_new/main_page.dart';
import '../../features/auth/login_screen.dart';
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
  static const String casepage = '/case';


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
      case personalinfo:
        return MaterialPageRoute(builder: (_) => PersonalInformationScreen());
      case accreditation:
        return MaterialPageRoute(builder: (_) => AccreditationSpl());

      case reset:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case mainPage:
        return MaterialPageRoute(builder: (_) => MainPage());
      case casepage:
       return MaterialPageRoute(builder: (_) => CasesPage());

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
