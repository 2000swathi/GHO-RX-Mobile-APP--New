import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/router/app_router.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GHORX App',

      // theme: ThemeData(
      //   // Generate a full color scheme from a seed color
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: AppColors.primary,
      //     brightness: Brightness.light, // light or dark mode
      //   ),

      //   // Optional: Customize text styles
      //   textTheme: const TextTheme(
      //     headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      //     bodyText1: TextStyle(fontSize: 16),
      //   ),

      //   // Optional: AppBar theme
      //   appBarTheme: const AppBarTheme(
      //     backgroundColor: AppColors.primary,
      //     foregroundColor: Colors.white,
      //     elevation: 0,
      //   ),

      //   // Optional: FloatingActionButton theme
      //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
      //     backgroundColor: AppColors.primary,
      //   ),
      // ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splash,
    );
  }
}
