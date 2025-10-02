import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/auth/otp_screen.dart';
import 'package:ghorx_mobile_app_new/features/auth/register_screen.dart';
<<<<<<< HEAD
import 'package:ghorx_mobile_app_new/features/home/home_scrn.dart';
=======
import 'package:ghorx_mobile_app_new/features/auth/repository/model/login_model.dart';
import 'package:ghorx_mobile_app_new/features/auth/reset_password.dart';
>>>>>>> origin/develop
import '../../features/auth/login_screen.dart';
import '../../features/splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
<<<<<<< HEAD
  static const String home = '/home';
=======
  static const String reset = '/reset';
>>>>>>> origin/develop

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case otp:
<<<<<<< HEAD
        return MaterialPageRoute(builder: (_) => OtpScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScrn());
=======
        final otpResponse = settings.arguments as OtpResponse;
        return MaterialPageRoute(
          builder: (_) => OtpScreen(otpResponse: otpResponse),
          settings: settings,
        );
      case reset:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
>>>>>>> origin/develop

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
