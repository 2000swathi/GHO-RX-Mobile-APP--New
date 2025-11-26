abstract class ChangePasswordEvent {}

class FetchChangePassword extends ChangePasswordEvent {
  String currentPw;
  String newPw;
  String confirmPw;
  FetchChangePassword({
    required this.currentPw,
    required this.newPw,
    required this.confirmPw,
  });
  List<Object> get props => [currentPw, newPw, confirmPw];
}
