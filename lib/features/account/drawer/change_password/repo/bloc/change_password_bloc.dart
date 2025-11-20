import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/drawer/change_password/repo/bloc/change_password_event.dart';
import 'package:ghorx_mobile_app_new/features/account/drawer/change_password/repo/changePasswordrepo.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final Changepasswordrepo repository;
  ChangePasswordBloc({required this.repository})
    : super(ChangePasswordInitial()) {
    on<FetchChangePassword>((event, emit) async {
      emit(CPLoading());
      try {
        final response = await repository.ChangePassword(
          currentPassword: event.currentPw,
          newPassword: event.newPw,
        );
        if (response["Status"] == 1) {
          final message =
              response["Info"]?.toString() ?? "Password updated successfully";

          emit(CPSuccess(message: message));
        } else {
          final error =
              response["Error"]?.toString() ?? "Failed to update Password";

          emit(CPError(message: error));
        }
      } catch (e) {
        emit(CPError(message: e.toString()));
      }
    });
  }
}
