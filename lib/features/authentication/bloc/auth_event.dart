abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class OTPValidate extends AuthEvent {
  final String email;
  final String otp;

  OTPValidate({required this.email, required this.otp});
}

class OTPResend extends AuthEvent {
  final String email;

  OTPResend({required this.email});
}

//forgot email
class ForgotEmail extends AuthEvent {
  final String email;

  ForgotEmail({required this.email});
}

//forgot otp
class ForgotOtp extends AuthEvent {
  final String email;
  final String otp;

  ForgotOtp({required this.email, required this.otp});
}


//logout
class Logout extends AuthEvent {}
