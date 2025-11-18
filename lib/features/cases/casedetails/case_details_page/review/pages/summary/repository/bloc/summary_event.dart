abstract class SummaryEvent {}

class summarycaseEvent extends SummaryEvent {
  final String saltID;
  final String summary;
   summarycaseEvent({
    required this.saltID,
    required this.summary
   });
}
