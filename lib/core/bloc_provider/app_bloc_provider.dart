import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<AuthBloc>(
        //   create: (_) => AuthBloc()..add(AppStartedEvent()),
        // ),
        // BlocProvider<HomeBloc>(
        //   create: (_) => HomeBloc(), // add initial events if needed
        // ),
      ],
      child: child,
    );
  }
}
