part of 'professinal_experince_bloc.dart';

sealed class ProfessinalExperinceState extends Equatable {
  const ProfessinalExperinceState();
  
  @override
  List<Object> get props => [];
}

final class ProfessinalExperinceInitial extends ProfessinalExperinceState {}

final class ProfessinalExperinceLoading extends ProfessinalExperinceState {}
final class ProfessinalExperinceAddLoading extends ProfessinalExperinceState {}
final class ProfessinalExperinceEditLoading extends ProfessinalExperinceState {}


class ProfessinalExperinceListState extends ProfessinalExperinceState {
  final ProfessionalExperienceModel experienceResponse;

  const ProfessinalExperinceListState({required this.experienceResponse});

  @override
  List<Object> get props => [experienceResponse];
}

class ExpSuccess extends ProfessinalExperinceState {
  final String message;

  const ExpSuccess({required this.message});

  @override
  List<Object> get props => [message];
} 

class ExpError extends ProfessinalExperinceState {
  final String message;

  const ExpError({required this.message});

  @override
  List<Object> get props => [message];
}

