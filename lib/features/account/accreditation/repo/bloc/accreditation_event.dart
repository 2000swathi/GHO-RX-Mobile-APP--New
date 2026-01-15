part of 'accreditation_bloc.dart';

sealed class AccreditationEvent extends Equatable {
  const AccreditationEvent();

  @override
  List<Object> get props => [];
}

class FetchAccreditation extends AccreditationEvent {

  const FetchAccreditation();
}

//edit accreditation
class SaveAccreditationEvent extends AccreditationEvent {
  final String accreditationtype;
  final String accreditationbody;

  const SaveAccreditationEvent({
    required this.accreditationtype,
    required this.accreditationbody,
  });

  @override
  List<Object> get props => [
        accreditationtype,
        accreditationbody,
      ];
}

