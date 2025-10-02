import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/spalsh_event.dart';
import 'bloc/splash_bloc.dart';
import 'bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashCompleted) {
            Navigator.pushReplacementNamed(context, '/personalinformation');
          }
        },
        child: Scaffold(body: Center(child: CustomLogo(isSplash: true))),
      ),
    );
  }
}
