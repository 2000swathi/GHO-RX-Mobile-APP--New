part of 'specialty_bloc.dart';

sealed class SpecialtyState extends Equatable {
  const SpecialtyState();
  
  @override
  List<Object> get props => [];
}

final class SpecialtyInitial extends SpecialtyState {}
