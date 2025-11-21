part of 'accreditation_bloc.dart';

sealed class AccreditationState extends Equatable {
  const AccreditationState();

  @override
  List<Object> get props => [];
}

final class AccreditationInitial extends AccreditationState {}

class AccrediationLoading extends AccreditationState {}

class AccrediationAddLoading extends AccreditationState {}

class AccrediationeditLoading extends AccreditationState {}

//Acreditation
class AccreditationgetState extends AccreditationState {
  final AccreditationModel accreditationModel;

  const AccreditationgetState({required this.accreditationModel});

  @override
  List<Object> get props => [AccreditationModel];
}

//add/edit success
class AccSuccess extends AccreditationState {
  final String message;

  const AccSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class AccrediationError extends AccreditationState {
  final String message;

  const AccrediationError({required this.message});

  @override
  List<Object> get props => [message];
}
