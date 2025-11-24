part of 'professionalref_bloc.dart';

sealed class ProfessionalrefEvent extends Equatable {
  const ProfessionalrefEvent();

  @override
  List<Object> get props => [];
}

class FetchProfessionalref extends ProfessionalrefEvent {}

class AddProRef extends ProfessionalrefEvent {
  final String fullName;
  final String designation;
  // final String designation1;
  final String relationship;
  final String phone;
  AddProRef({
    required this.fullName,
    required this.designation,
    // required this.designation1,
    required this.relationship,
    required this.phone,
  });
}
