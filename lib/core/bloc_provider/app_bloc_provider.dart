import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/auth/bloc/auth_bloc.dart';
import 'package:ghorx_mobile_app_new/features/auth/repository/auth_repository.dart';
import 'package:ghorx_mobile_app_new/features/profile/bloc/personal_info_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/repository/country_repository.dart';
import 'package:ghorx_mobile_app_new/features/splash/bloc/spalsh_event.dart';
import 'package:ghorx_mobile_app_new/features/splash/bloc/splash_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (_) => SplashBloc()..add(SplashStarted()),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepository: AuthRepository()),
        ),
        BlocProvider<PersonalInfoBloc>(
          create:
              (_) => PersonalInfoBloc(repository: CountryRepository()),
        ),
      ],
      child: child,
    );
  }
}
