part of 'delete_bloc.dart';

sealed class DeleteState extends Equatable {
  const DeleteState();
  
  @override
  List<Object> get props => [];
}

final class DeleteInitial extends DeleteState {}
