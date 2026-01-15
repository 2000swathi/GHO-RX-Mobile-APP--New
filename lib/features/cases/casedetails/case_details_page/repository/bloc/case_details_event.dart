abstract class CaseDetailsEvent {}

class CaseDetailsEventRequested extends CaseDetailsEvent {
  final String caseID;
  final String caseReviewerID;
  final bool silent;

  CaseDetailsEventRequested({required this.caseID,required this.caseReviewerID ,this.silent = false});
}
