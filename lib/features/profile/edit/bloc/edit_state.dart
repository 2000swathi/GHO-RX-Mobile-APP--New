part of 'edit_bloc.dart';

sealed class EditState extends Equatable {
  const EditState();
  
  @override
  List<Object> get props => [];
}

final class EditInitial extends EditState {}
