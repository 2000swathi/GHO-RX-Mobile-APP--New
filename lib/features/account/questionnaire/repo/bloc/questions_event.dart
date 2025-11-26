part of 'questions_bloc.dart';

abstract class QuestionsEvent {}

class CheckQuestionsEvent extends QuestionsEvent {
  final String qID;
  final bool answer;
  final String comments;

  CheckQuestionsEvent({
    required this.qID,
    required this.answer,
    required this.comments,
  });

  @override
  List<Object?> get props => [qID, answer, comments];
}

class FetchQuestionsEvent extends QuestionsEvent {}
