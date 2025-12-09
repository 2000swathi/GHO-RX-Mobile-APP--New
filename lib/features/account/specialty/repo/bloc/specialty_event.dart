part of 'specialty_bloc.dart';

sealed class SpecialtyEvent extends Equatable {
  const SpecialtyEvent();

  @override
  List<Object> get props => [];
}

class FetchSpecialty extends SpecialtyEvent {}
//specialty
class AddSpecialty extends SpecialtyEvent {
  final String specialty;
  final String certifiedBoard;
  final String specialtyType;

  const AddSpecialty({
    required this.specialty,
    required this.certifiedBoard,
    required this.specialtyType,
  });
}
//edit
class EditSpecialtyEvent extends SpecialtyEvent {
  final String id;
  final String specialtyId;
  final String certifiedBoard;
  final String specialtyType;
  const EditSpecialtyEvent({
    required this.id,
    required this.specialtyId,
    required this.certifiedBoard,
    required this.specialtyType,
  });

  @override
  List<Object> get props => [
        id,
        specialtyId,
        certifiedBoard,
        specialtyType,
      ];
}
