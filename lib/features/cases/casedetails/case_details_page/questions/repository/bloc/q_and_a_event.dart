abstract class QAndAEvent {}

class saveQandAEvent extends QAndAEvent {
  final String saltID;
  final String questID;
  final String answer;
  final String support;

  saveQandAEvent({
    required this.saltID,
    required this.questID,
    required this.answer,
    required this.support,
  });
}
