part of 'add_bloc.dart';

sealed class AddState extends Equatable {
  const AddState();

  @override
  List<Object> get props => [];
}

final class AddInitial extends AddState {}

final class AddLoading extends AddState {}

// add specialty
class AddSpecialtyInfoState extends AddState {
  const AddSpecialtyInfoState();

  @override
  List<Object> get props => [];
}

//error
class AddError extends AddState {
  final String message;

  const AddError({required this.message});

  @override
  List<Object> get props => [message];
}
