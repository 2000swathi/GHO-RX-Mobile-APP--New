import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/splash/bloc/spalsh_event.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>((event, emit) async {
      emit(SplashLoading());

      await Future.delayed(const Duration(seconds: 2));

      final token = await SharedPreference.getToken();
      final userId = await SharedPreference.getUserId();

      final isLoggedIn = token != null && token.isNotEmpty && userId != null && userId.isNotEmpty;

      emit(SplashCompleted(isLoggedIn));
    });
  }
}
