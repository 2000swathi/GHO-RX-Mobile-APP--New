import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/accreditation_screen.dart';
import 'package:ghorx_mobile_app_new/features/account/documents/documents_screen.dart';
import 'package:ghorx_mobile_app_new/features/account/education/education_screen.dart';
import 'package:ghorx_mobile_app_new/features/account/languages/language_screen.dart';
import 'package:ghorx_mobile_app_new/features/account/drawer/change_password/change_password.dart';
import 'package:ghorx_mobile_app_new/features/account/logout/logout_scrn.dart';
import 'package:ghorx_mobile_app_new/features/account/license/licensescreen.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/personal_information.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/insurance.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/professional_references.dart';
import 'package:ghorx_mobile_app_new/features/account/questionnaire/questionnaire_screen.dart';
import 'package:ghorx_mobile_app_new/features/account/specialty/specialty_screen.dart';
import 'package:ghorx_mobile_app_new/features/authentication/otp_screen.dart';
import 'package:ghorx_mobile_app_new/features/authentication/repository/model/login_model.dart';
import 'package:ghorx_mobile_app_new/features/authentication/add_page.dart';
import 'package:ghorx_mobile_app_new/features/authentication/reset_password.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/casedetails.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/cases_page.dart';
import 'package:ghorx_mobile_app_new/features/send%20mail/send_message.dart';
import 'package:ghorx_mobile_app_new/features/home/home_page.dart';
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
  static const String mainPage = '/mainpage';
  static const String personalInfo = '/personalInfo';
  static const String drSpecialty = '/drSpecialty';
  static const String drInsurance = '/drInsurance';
  static const String drLicense = '/drLicense';
  static const String casepage = '/case';
  static const String casedetails = '/casedetails';
  static const String homePage = '/homepage';
  static const String Message = '/messages';
  static const String languagescreen = '/languagescreen';
  static const String licensescreen = '/licensescreen';
  static const String educationscreen = '/educationscreen';
  static const String accreditationscreen = '/accreditationscreen';
  static const String professionalreferences = '/professionalreferences';
  static const String profesindInsurance = '/professionalindemnityinsurance';
  static const String documents = '/documents';
  static const String questionnaire = '/questionnaire';
  static const String specialty = '/specialty';



  //profile
  static const String changePW = '/changePW';
  static const String logout = '/logout';
  static const String delAcc = '/delAcc';

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
      case casepage:
        return MaterialPageRoute(builder: (_) => CasesPage());
      case casedetails:
        return MaterialPageRoute(
          builder: (_) => CaseDetailsPage(),
          settings: settings,
        );
      case Message:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => SendMessage(from: args['from'], to: args['to']),
        );

      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case personalinformation:
        return MaterialPageRoute(builder: (_) => PersonalInformationScreen());
      case languagescreen:
        return MaterialPageRoute(builder: (_) => LanguageScreen());
      case licensescreen:
        return MaterialPageRoute(builder: (_) => Licensescreen());
      case educationscreen:
        return MaterialPageRoute(builder: (_) => EducationScreen());
      case accreditationscreen:
        return MaterialPageRoute(builder: (_) => AccreditationScreen());
      case professionalreferences:
        return MaterialPageRoute(builder: (_) => ProfessionalReferencesScreen());
      case profesindInsurance:
        return MaterialPageRoute(builder: (_) => InsuranceScreen());
      case documents:
        return MaterialPageRoute(builder: (_) => DocumentsScreen());
      case questionnaire:
        return MaterialPageRoute(builder: (_) => QuestionnaireScreen());
      case specialty:
        return MaterialPageRoute(builder: (_) => SpecialtyScreen());

      //profile
      case changePW:
        return MaterialPageRoute(builder: (_) => ChangePassword());
      case logout:
        return MaterialPageRoute(builder: (_) => LogoutScrn());
      case delAcc:
        return MaterialPageRoute(builder: (_) => LogoutScrn());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
