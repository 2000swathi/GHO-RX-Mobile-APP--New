abstract class AttestEvent {}

class AttestListEvent extends AttestEvent {
  final String saltID;
   final bool silent;
  AttestListEvent({required this.saltID,this.silent = false});
}
