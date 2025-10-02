import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/auth/repository/auth_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final OtpResponse otpResponse;

  const AuthSuccess(this.otpResponse);

  @override
  List<Object?> get props => [otpResponse];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}
