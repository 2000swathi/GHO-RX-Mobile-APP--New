abstract class CaseDetailsEvent {}

class CaseDetailsEventRequested extends CaseDetailsEvent {
  final String saltID;
  final bool silent;

  CaseDetailsEventRequested({required this.saltID, this.silent = false});
}
