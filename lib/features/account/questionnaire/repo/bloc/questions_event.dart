part of 'questions_bloc.dart';

abstract class QuestionsEvent {}

class FetchQuestionsEvent extends QuestionsEvent {
  final String qID;
  final bool answer;
  final String comments;

  FetchQuestionsEvent({
    required this.qID,
    required this.answer,
    required this.comments,
  });

  @override
  List<Object?> get props => [qID, answer, comments];
}
