part of 'professinal_experince_bloc.dart';

sealed class ProfessinalExperinceEvent extends Equatable {
  const ProfessinalExperinceEvent();

  @override
  List<Object> get props => [];
}

class FetchExperience extends ProfessinalExperinceEvent {}

//add experience
class AddExperience extends ProfessinalExperinceEvent {
  final String institution;
  final String designation;
  final String fromMonth;
  final String fromYear;
  final String toMonth;
  final String toYear;
  final String comments;

  AddExperience({
    required this.institution,
    required this.designation,
    required this.fromMonth,
    required this.fromYear,
    required this.toMonth,
    required this.toYear,
    required this.comments,
  });
}

//edit experience
class EditExperience extends ProfessinalExperinceEvent{
  final String id;
  final String institution;
  final String designation;
  final String fromMonth;
  final String fromYear;
  final String toMonth;
  final String toYear;
  final String comments;

  EditExperience({
    required this.id,
    required this.institution,
    required this.designation,
    required this.fromMonth,
    required this.fromYear,
    required this.toMonth,
    required this.toYear,
    required this.comments,
  });

  @override
  List<Object> get props => [
    id,
    institution, 
    designation, 
    fromMonth, 
    fromYear, 
    toMonth, 
    toYear, 
    comments
  ];
}


