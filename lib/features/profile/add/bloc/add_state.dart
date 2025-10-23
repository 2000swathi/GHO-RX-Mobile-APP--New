part of 'add_bloc.dart';

sealed class AddState extends Equatable {
  const AddState();

  @override
  List<Object> get props => [];
}

final class AddInitial extends AddState {}

final class AddLoading extends AddState {}

// add specialty
class AddSpecialtyInfoState extends AddState {
  const AddSpecialtyInfoState();

  @override
  List<Object> get props => [];
}

//add accreditation
class AddAccrediationInfoState extends AddState {
  final Map<String, dynamic> response;
  const AddAccrediationInfoState({required this.response});

  @override
  List<Object> get props => [];
}

//add insurance
class AddInsuranceInfoState extends AddState {
  final Map<String, dynamic> response;
  const AddInsuranceInfoState({required this.response});

  @override
  List<Object> get props => [response];
}

//add license
class AddLicenseInfoState extends AddState {
  final Map<String, dynamic> response;
  const AddLicenseInfoState({required this.response});
  @override
  List<Object> get props => [response];
}

//add language
class AddLanguageInfoState extends AddState {
  final Map<String, dynamic> response;
  const AddLanguageInfoState({required this.response});
  @override
  List<Object> get props => [response];
}

//add Bank Info
class AddBankInfoState extends AddState {
  final Map<String, dynamic> response;
  const AddBankInfoState({required this.response});
  @override
  List<Object> get props => [response];
}

//error
class AddError extends AddState {
  final String message;

  const AddError({required this.message});

  @override
  List<Object> get props => [message];
}
