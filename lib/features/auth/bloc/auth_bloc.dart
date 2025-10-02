import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final otpResponse  = await authRepository.login(
          email: event.email,
          password: event.password,
        );
        emit(AuthSuccess(otpResponse));
      } on Exception catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
