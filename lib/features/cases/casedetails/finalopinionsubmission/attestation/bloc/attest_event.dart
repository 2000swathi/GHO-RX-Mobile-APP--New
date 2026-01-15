abstract class AttestEvent {}

class AttestListEvent extends AttestEvent {
  final String caseReviewerID;
  final int attestationID;
  final bool silent;
  AttestListEvent({
    required this.caseReviewerID,
    required this.attestationID,
    this.silent = false,
  });
}
