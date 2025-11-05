part of 'case_details_bloc.dart';

sealed class CaseDetailsState extends Equatable {
  const CaseDetailsState();

  @override
  List<Object> get props => [];
}

final class CaseDetailsInitial extends CaseDetailsState {}

final class CaseDetailsLoading extends CaseDetailsState {}

//case details
final class casedetailsSuccess extends CaseDetailsState {
  final CaseDetailsModel caseDetailsModel;
  const casedetailsSuccess({required this.caseDetailsModel});
  @override
  List<Object> get props => [caseDetailsModel];
}

final class casedetailsFailure extends CaseDetailsState {
  final String error;

  const casedetailsFailure(this.error);

  @override
  List<Object> get props => [error];
}
