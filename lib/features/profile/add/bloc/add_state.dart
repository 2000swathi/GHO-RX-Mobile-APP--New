part of 'add_bloc.dart';

sealed class AddState extends Equatable {
  const AddState();

  @override
  List<Object> get props => [];
}

final class AddInitial extends AddState {}

final class AddLoading extends AddState {}

// //add success
// final class AddSuccess extends AddState {
//   final String message;

//   const AddSuccess({required this.message});

//   @override
//   List<Object> get props => [message];
// }

//add success
final class AddSuccess extends AddState {
  final String message;

  const AddSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

// add specialty
class AddSpecialtyInfoState extends AddState {
  const AddSpecialtyInfoState();

  @override
  List<Object> get props => [];
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

//add accreditation
class AddAccrediationInfoState extends AddState {
  const AddAccrediationInfoState();

  @override
  List<Object> get props => [];
}

//add insurance
class AddInsuranceInfoState extends AddState {
  const AddInsuranceInfoState();

  @override
  List<Object> get props => [];
}

//add license
class AddLicenseInfoState extends AddState {
  const AddLicenseInfoState();

  @override
  List<Object> get props => [];
}

//error
class AddError extends AddState {
  final String message;

  const AddError({required this.message});

  @override
  List<Object> get props => [message];
}
