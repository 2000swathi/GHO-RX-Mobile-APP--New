part of 'questions_bloc.dart';

abstract class QuestionsEvent {}

class AddQuestionsEvent extends QuestionsEvent {
  final String id;
  final String value;

  AddQuestionsEvent({required this.id,required this.value});

  List<Object?> get props => [id];
}

class FetchQuestionsEvent extends QuestionsEvent {}

