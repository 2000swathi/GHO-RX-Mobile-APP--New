import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/auth/repository/model/login_model.dart';
import 'package:ghorx_mobile_app_new/features/auth/repository/model/otp_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

// login
class AuthSuccess extends AuthState {
  final OtpResponse otpResponse;

  const AuthSuccess(this.otpResponse);

  @override
  List<Object?> get props => [otpResponse];
}

// otpvalidate
class AuthOTPSuccess extends AuthState {
  final OtpVerifyResponse otpVerifyResponse;

  const AuthOTPSuccess(this.otpVerifyResponse);

  @override
  List<Object?> get props => [otpVerifyResponse];
}
//otpresend
class ResendOTPSuccess extends AuthState {
  final OtpResponse otpResponse;

  const ResendOTPSuccess(this.otpResponse);

  @override
  List<Object?> get props => [otpResponse];
}


class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}
