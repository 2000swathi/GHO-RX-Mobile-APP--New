part of 'questions_bloc.dart';

sealed class QuestionsState extends Equatable {
  const QuestionsState();
  
  @override
  List<Object> get props => [];
}

final class QuestionsInitial extends QuestionsState {}
