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

//edit
class EditProRef extends ProfessionalrefEvent {
  final String refId;
  final String fullName;
  final String designation;
  final String relationship;
  final String phone;

  const EditProRef({
    required this.refId,
    required this.fullName,
    required this.designation,
    required this.relationship,
    required this.phone,
  });
  @override
  List<Object> get props => [refId, fullName, designation, relationship, phone];
}
