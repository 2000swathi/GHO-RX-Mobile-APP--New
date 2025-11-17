part of 'specialty_bloc.dart';

sealed class SpecialtyState extends Equatable {
  const SpecialtyState();

  @override
  List<Object> get props => [];
}

final class SpecialtyInitial extends SpecialtyState {}

class SpecialityLoading extends SpecialtyState {}

// specialty list
class Specialty extends SpecialtyState {
  final SpecialtyModel specialtyModel;

  const Specialty({required this.specialtyModel});

  @override
  List<Object> get props => [specialtyModel];
}

class SpecialityError extends SpecialtyState {
  final String message;

  const SpecialityError({required this.message});

  @override
  List<Object> get props => [message];
}
