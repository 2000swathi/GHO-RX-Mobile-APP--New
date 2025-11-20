abstract class ChangePasswordEvent {}

class FetchChangePassword extends ChangePasswordEvent {
  String currentPw;
  String newPw;
  FetchChangePassword({required this.currentPw, required this.newPw});
  List<Object> get props => [currentPw, newPw];
}
