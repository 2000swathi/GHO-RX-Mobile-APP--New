part of 'edit_bloc.dart';

sealed class EditState extends Equatable {
  const EditState();

  @override
  List<Object> get props => [];
}

final class EditInitial extends EditState {}

final class EditLoading extends EditState {}

// success
final class EditSuccess extends EditState {
  final String message;

  const EditSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

//Edit license
class EditLicenseInfoState extends EditState {
  const EditLicenseInfoState();

  @override
  List<Object> get props => [];
}

//Edit language
class EditLanguageInfoState extends EditState {
  const EditLanguageInfoState();

  @override
  List<Object> get props => [];
}

class EditBankInfoState extends EditState {
  const EditBankInfoState();

  @override
  List<Object> get props => [];
}

//specialty
class EditSpecialtyInfoState extends EditState {
  const EditSpecialtyInfoState();

  @override
  List<Object> get props => [];
}

//accrediation
class EditAccrediationInfoState extends EditState {
  const EditAccrediationInfoState();

  @override
  List<Object> get props => [];
}

//insurance
class EditInsuranceInfoState extends EditState {
  const EditInsuranceInfoState();

  @override
  List<Object> get props => [];
}

//ERROR
final class EditFailure extends EditState {
  final String error;

  const EditFailure({required this.error});

  @override
  List<Object> get props => [error];
}
