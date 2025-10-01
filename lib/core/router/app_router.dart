import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/auth/otp_screen.dart';
import 'package:ghorx_mobile_app_new/features/auth/register_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case otp:
        return MaterialPageRoute(builder: (_) => OtpScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
