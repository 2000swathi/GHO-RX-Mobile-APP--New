abstract class UpdateState {}

class UpdateInitial extends UpdateState {}

class UpdateChecking extends UpdateState {}

class UpdateAvailable extends UpdateState {
  final bool forceUpdate;

  UpdateAvailable({required this.forceUpdate});
}

class UpdateNotAvailable extends UpdateState {}

class UpdateError extends UpdateState {
  final String message;

  UpdateError(this.message);
}