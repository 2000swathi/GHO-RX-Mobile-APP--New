part of 'add_bloc.dart';

sealed class AddState extends Equatable {
  const AddState();
  
  @override
  List<Object> get props => [];
}

final class AddInitial extends AddState {}
