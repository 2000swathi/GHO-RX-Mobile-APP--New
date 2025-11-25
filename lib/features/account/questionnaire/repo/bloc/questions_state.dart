part of 'questions_bloc.dart';

abstract class QuestionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoading extends QuestionsState {
  final String questionId;
  QuestionsLoading(this.questionId);

  @override
  List<Object?> get props => [questionId];
}

class QuestionsLoaded extends QuestionsState {
  final String message;
  final String questionId;

  QuestionsLoaded({required this.message, required this.questionId});

  @override
  List<Object?> get props => [message, questionId];
}

class QuestionsError extends QuestionsState {
  final String message;
  final String questionId;

  QuestionsError({required this.message, required this.questionId});

  @override
  List<Object?> get props => [message, questionId];
}
