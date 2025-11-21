part of 'professionalref_bloc.dart';

sealed class ProfessionalrefState extends Equatable {
  const ProfessionalrefState();

  @override
  List<Object> get props => [];
}

final class ProfessionalrefInitial extends ProfessionalrefState {}

class ProfessionalrefLoading extends ProfessionalrefState {}

//professional ref
class ProfessionalrefState(final ProfessionalerefModel professionalerefModel({required this.professionalerefModel}))