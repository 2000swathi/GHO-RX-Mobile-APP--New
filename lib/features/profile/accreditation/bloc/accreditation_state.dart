part of 'accreditation_bloc.dart';

sealed class AccreditationState extends Equatable {
  const AccreditationState();

  @override
  List<Object> get props => [];
}

final class AccreditationInitial extends AccreditationState {}

class AccrediationLoading extends AccreditationState {}

//Acreditation
class Accreditation extends AccreditationState {
  final AccreditationModel accreditationModel;

  const Accreditation({required this.accreditationModel});

  @override
  List<Object> get props => [AccreditationModel];
}

class AccrediationError extends AccreditationState {
  final String message;

  const AccrediationError({required this.message});

  @override
  List<Object> get props => [message];
}
