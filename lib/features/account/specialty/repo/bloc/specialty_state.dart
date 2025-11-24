part of 'specialty_bloc.dart';

sealed class SpecialtyState extends Equatable {
  const SpecialtyState();

  @override
  List<Object> get props => [];
}

final class SpecialtyInitial extends SpecialtyState {}

class SpecialityLoading extends SpecialtyState {}
class SpecialityAddLoading extends SpecialtyState {}
class SpecialityEditLoading extends SpecialtyState {}

// specialty list
class SpecialtyGetState extends SpecialtyState {
  final SpecialtyModel specialtyModel;

  const SpecialtyGetState({required this.specialtyModel});

  @override
  List<Object> get props => [specialtyModel];
}
class SpecialtySuccess extends SpecialtyState {
  final String message;

  const SpecialtySuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class SpecialtyError extends SpecialtyState {
  final String message;

  const SpecialtyError({required this.message});

  @override
  List<Object> get props => [message];
}
