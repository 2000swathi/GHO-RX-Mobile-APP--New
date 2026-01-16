part of 'accreditation_bloc.dart';

sealed class AccreditationEvent extends Equatable {
  const AccreditationEvent();

  @override
  List<Object> get props => [];
}

class FetchAccreditation extends AccreditationEvent {}


//add accreditation
class AddAccreditationEvent extends AccreditationEvent {
  final String accreditationName;

  const AddAccreditationEvent({required this.accreditationName});

  @override
  List<Object> get props => [accreditationName];
}
