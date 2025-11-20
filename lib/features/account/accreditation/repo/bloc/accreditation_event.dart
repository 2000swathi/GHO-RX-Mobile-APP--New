part of 'accreditation_bloc.dart';

sealed class AccreditationEvent extends Equatable {
  const AccreditationEvent();

  @override
  List<Object> get props => [];
}

class FetchAccreditation extends AccreditationEvent {}

//add Accreditation
class AddAccrediation extends AccreditationEvent {
  final String accreditationtype;
  final String accreditationbody;
  final String accreditationnumber;

  AddAccrediation({
    required this.accreditationtype,
    required this.accreditationbody,
    required this.accreditationnumber,
  });
}
// accreditation
class EditAcreditationEvent extends AccreditationEvent {
  final String accreditationId;
  final String accreditationtype;
  final String accreditationbody;
  final String accreditationnumber;

  const EditAcreditationEvent({
    required this.accreditationId,
    required this.accreditationtype,
    required this.accreditationbody,
    required this.accreditationnumber,
  });

  @override
  List<Object> get props => [
    accreditationId,
    accreditationtype,
    accreditationbody,
    accreditationnumber,
  ];
}
