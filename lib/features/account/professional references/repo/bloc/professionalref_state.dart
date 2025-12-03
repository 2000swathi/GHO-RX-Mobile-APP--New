part of 'professionalref_bloc.dart';

sealed class ProfessionalrefState extends Equatable {
  const ProfessionalrefState();

  @override
  List<Object> get props => [];
}

final class ProfessionalrefInitial extends ProfessionalrefState {}

class ProfessionalrefLoading extends ProfessionalrefState {}

class ProfessionalrefAddLoading extends ProfessionalrefState {}

class ProfessionalrefEditLoading extends ProfessionalrefState {}

// Fetch success state
class ProfessionalrefgetState extends ProfessionalrefState {
  final ProfessionalerefModel professionalerefModel;
  const ProfessionalrefgetState({required this.professionalerefModel});

  @override
  List<Object> get props => [professionalerefModel];
}

// Add / Edit success
class ProRefSuccess extends ProfessionalrefState {
  final String message;
  const ProRefSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

// Failure
class ProfessionalrefError extends ProfessionalrefState {
  final String message;
  const ProfessionalrefError({required this.message});

  @override
  List<Object> get props => [message];
}
