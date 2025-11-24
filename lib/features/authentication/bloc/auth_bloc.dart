import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';
import '../repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    //login
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final otpResponse = await authRepository.login(
          email: event.email,
          password: event.password,
        );
        if (otpResponse.status == 1) {
          emit(AuthSuccess(otpResponse));
        } else {
          emit(
            AuthFailure(
              otpResponse.info.isNotEmpty
                  ? otpResponse.info
                  : "Invalid credentials...",
            ),
          );
        }
      } on Exception catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    //otpvalidate
    on<OTPValidate>((event, emit) async {
      emit(AuthLoading());
      try {
        final otpVerifyResponse = await authRepository.otp(
          email: event.email,
          otp: event.otp,
        );
        if (otpVerifyResponse.status == 1) {
          final otpData =
              otpVerifyResponse.data.isNotEmpty &&
                      otpVerifyResponse.data[0].isNotEmpty
                  ? otpVerifyResponse.data[0][0]
                  : null;

          if (otpData != null) {
            await SharedPreference.saveAuthData(
              token: otpData.token,
              userId: otpData.id,
            );
          }

          emit(AuthOTPSuccess(otpVerifyResponse));
        } else {
          emit(
            AuthFailure(
              otpVerifyResponse.info.isNotEmpty
                  ? otpVerifyResponse.info
                  : "Invalid credentials...",
            ),
          );
        }
      } on Exception catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    //resend otp
    on<OTPResend>((event, emit) async {
      emit(AuthLoading());
      try {
        final otpresendResponse = await authRepository.otpResend(
          email: event.email,
        );
        if (otpresendResponse.status == 1) {
          emit(ResendOTPSuccess(otpresendResponse));
        } else {
          emit(
            AuthFailure(
              otpresendResponse.info.isNotEmpty
                  ? otpresendResponse.info
                  : "Invalid credentials...",
            ),
          );
        }
      } on Exception catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    //forgot email
    on<ForgotEmail>((event, emit) async {
      emit(AuthLoading());
      try { 
        final message = await authRepository.forgotEmail(
          email: event.email,
        );
        emit(ForgotEmailSuccess(message));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    //logout
    on<Logout>((event, emit) async {
      emit(AuthLoading());
      try {
        await SharedPreference.clear();
        emit(const LogoutSuccess(true));
      } on Exception catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
