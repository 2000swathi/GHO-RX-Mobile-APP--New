import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/auth/reset_password.dart';
import '../../features/auth/login_screen.dart';
import '../../features/splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String reset = '/reset';



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());
      case reset:
        return MaterialPageRoute(builder: (_) =>  ResetPasswordScreen());
 
           
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
