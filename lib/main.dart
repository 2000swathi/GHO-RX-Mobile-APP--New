import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/bloc_provider/app_bloc_provider.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
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
    return AppBlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GHORX App',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundcolor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primarycolor,
            brightness: Brightness.light,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.backgroundcolor,
            foregroundColor: AppColors.white,
            elevation: 0,
          ),
        ),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.splash,
      ),
    );
  }
}
