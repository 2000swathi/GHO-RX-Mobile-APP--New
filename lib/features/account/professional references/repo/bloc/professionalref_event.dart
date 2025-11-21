part of 'professionalref_bloc.dart';

sealed class ProfessionalrefEvent extends Equatable {
  const ProfessionalrefEvent();

  @override
  List<Object> get props => [];
}

class FetchProfessionalref extends ProfessionalrefEvent {}
