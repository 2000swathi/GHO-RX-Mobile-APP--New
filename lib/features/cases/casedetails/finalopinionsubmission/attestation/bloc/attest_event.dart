abstract class AttestEvent {}

class AttestListEvent extends AttestEvent {
  final String saltID;
  AttestListEvent({required this.saltID});
}
