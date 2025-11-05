abstract class CaseDetailsEvent {}

class CaseDetailsEventRequested extends CaseDetailsEvent {
  final String saltID;

  CaseDetailsEventRequested({required this.saltID});
}
