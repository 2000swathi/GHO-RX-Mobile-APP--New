part of 'q_and_a_bloc.dart';

sealed class QAndAState extends Equatable {
  const QAndAState();

  @override
  List<Object> get props => [];
}

final class QAndAInitial extends QAndAState {}

final class QAndALoading extends QAndAState {}

//success
final class QAndASuccess extends QAndAState {
  final Map<String, dynamic> response;

  const QAndASuccess({required this.response});

  @override
  List<Object> get props => [response];
}

//failure
final class QAndAFailure extends QAndAState {
  final String message;

  const QAndAFailure({required this.message});

  @override
  List<Object> get props => [message];
}
