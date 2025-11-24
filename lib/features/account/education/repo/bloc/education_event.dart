part of 'education_bloc.dart';

sealed class EducationEvent extends Equatable {
  const EducationEvent();

  @override
  List<Object> get props => [];
}

class FetchEducation extends EducationEvent {}

//add education
class AddEducation extends EducationEvent {
  final String institution;
  final String degree;
  final String duration;
  final String year;
  final String comments;

  AddEducation({
    required this.institution,
    required this.degree,
    required this.duration,
    required this.year,
    required this.comments,
  });
}

//edit education
class EditEducation extends EducationEvent{
  final String id;
  final String institution;
  final String degree;
  final String duration;
  final String year;
  final String comments;

  EditEducation({
    required this.id,
    required this.institution,
    required this.degree,
    required this.duration,
    required this.year,
    required this.comments,
  });

  @override
  List<Object> get props => [
    id,
    institution, 
    degree, 
    duration, 
    year, 
    comments
  ];
}
