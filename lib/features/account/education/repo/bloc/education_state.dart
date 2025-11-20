part of 'education_bloc.dart';

sealed class EducationState extends Equatable {
  const EducationState();
  
  @override
  List<Object> get props => [];
}

final class EducationInitial extends EducationState {}

final class EducationLoading extends EducationState {}

class EducationListState extends EducationState {
  final EducationResponse educationResponse;

  const EducationListState({required this.educationResponse});

  @override
  List<Object> get props => [educationResponse];

}

class EduSuccess extends EducationState {
  final String message;

  const EduSuccess({required this.message});

  @override
  List<Object> get props => [message];
} 

class EducationError extends EducationState {
  final String message;

  const EducationError({required this.message});

  @override
  List<Object> get props => [message];
}

