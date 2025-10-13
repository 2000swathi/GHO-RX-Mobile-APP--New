import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/authentication/bloc/auth_bloc.dart';
import 'package:ghorx_mobile_app_new/features/authentication/repository/auth_repository.dart';
import 'package:ghorx_mobile_app_new/features/home/bloc/home_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/home_repository.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/list_repository.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/profile_repo.dart';
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
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(repository: ProfileRepository()),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(repository: HomeRepository()),
        ),
        BlocProvider<ListBloc>(
          create: (_) => ListBloc(repository: ListRepository()),
        ),
      ],
      child: child,
    );
  }
}
