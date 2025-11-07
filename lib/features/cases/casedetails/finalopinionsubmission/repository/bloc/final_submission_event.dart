

abstract class FinalSubmissionEvent{
}
class SubmitCaseEvent extends FinalSubmissionEvent {
  final String saltID;
  SubmitCaseEvent({required this.saltID});
}