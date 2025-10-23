part of 'delete_bloc.dart';

sealed class DeleteState extends Equatable {
  const DeleteState();
  
  @override
  List<Object> get props => [];
}

final class DeleteInitial extends DeleteState {}
final class DeleteLoading extends DeleteState {}
final class DeleteSuccess extends DeleteState {
  final String message;

  const DeleteSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class DeleteFailure extends DeleteState {
  final String error;

  const DeleteFailure({required this.error});

  @override
  List<Object> get props => [error];
}
