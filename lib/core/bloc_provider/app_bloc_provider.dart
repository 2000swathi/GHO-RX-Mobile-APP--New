import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/authentication/bloc/auth_bloc.dart';
import 'package:ghorx_mobile_app_new/features/authentication/repository/auth_repository.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/bloc/case_details_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/repository/case_det_repository.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/tab_contents/bloc/open_closed_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/tab_contents/repository/open_closed_repo.dart';
import 'package:ghorx_mobile_app_new/features/home/bloc/home_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/home_repository.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/delete/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/delete/repository/delete_repository.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/repository/edit_repository.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/repository/add_profile_repo.dart';
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
        BlocProvider<AddBloc>(
          create: (_) => AddBloc(repository: AddProfileRepository()),
        ),
        BlocProvider<EditBloc>(
          create: (_) => EditBloc(repository: EditprofileRepository()),
        ),
        BlocProvider<DeleteBloc>(
          create: (_) => DeleteBloc(repository: DeleteProfileRepository()),
        ),
        BlocProvider<OpenClosedBloc>(
          create: (_) => OpenClosedBloc(repository: OpenClosedRepository()),
        ),
        BlocProvider<CaseDetailsBloc>(
          create: (_) => CaseDetailsBloc(repository: CaseDetRepository()),
        ),
      ],
      child: child,
    );
  }
}
