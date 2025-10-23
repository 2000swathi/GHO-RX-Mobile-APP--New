part of 'add_bloc.dart';

sealed class AddState extends Equatable {
  const AddState();

  @override
  List<Object> get props => [];
}

final class AddInitial extends AddState {}

final class AddLoading extends AddState {}

// add success
class AddSuccess extends AddState {
  final Map<String, dynamic> response;

  const AddSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

//error
class AddError extends AddState {
  final String message;

  const AddError({required this.message});

  @override
  List<Object> get props => [message];
}
