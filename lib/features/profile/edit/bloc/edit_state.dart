part of 'edit_bloc.dart';

sealed class EditState extends Equatable {
  const EditState();
  
  @override
  List<Object> get props => [];
}

final class EditInitial extends EditState {}
final class EditLoading extends EditState {}
// success
final class EditSuccess extends EditState {
  final String message;
  
  const EditSuccess({required this.message});
  
  @override
  List<Object> get props => [message];
}

//ERROR
final class EditFailure extends EditState {
  final String error;

  const EditFailure({required this.error});

  @override
  List<Object> get props => [error];
}
