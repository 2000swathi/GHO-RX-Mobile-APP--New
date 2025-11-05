part of 'list_bloc.dart';

sealed class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

final class ListInitial extends ListState {}

class ListLoading extends ListState {}

// counryList
class CountryState extends ListState {
  final CountryResponseModel countryResponse;
  const CountryState({required this.countryResponse});
  @override
  List<Object> get props => [countryResponse];
}

// specialtylist
class SpecialtyListState extends ListState {
  final SpecialtyResponseModel specialtyResponse;
  const SpecialtyListState({required this.specialtyResponse});
  @override
  List<Object> get props => [specialtyResponse];
}

//accreditationtype
class AccreditationTypeListState extends ListState {
  final AccreditationTypeModel accreditationTypeResponse;
  const AccreditationTypeListState({required this.accreditationTypeResponse});
  @override
  List<Object> get props => [accreditationTypeResponse];
}

//License
class LicenseListState extends ListState {
  final LicenseListResponseModel licenseResponse;
  const LicenseListState({required this.licenseResponse});
  @override
  List<Object> get props => [licenseResponse];
}
//License
class AuthorityListState extends ListState {
  final IsuuingAuthResponseModel response;
  const AuthorityListState({required this.response});
  @override
  List<Object> get props => [response];
}

//List Failure
class ListFailure extends ListState {
  final String error;

  const ListFailure({required this.error});

  @override
  List<Object> get props => [error];
}

//Certified

class CertifiedListState extends ListState {
  final CertifiedResponseModel certifiedResponse;
  const CertifiedListState({required this.certifiedResponse});
  @override
  List<Object> get props => [certifiedResponse];
}

//Specialty Type

class SpecialtyTypeListState extends ListState {
  final SpecialtyTypeResponseModel specialtyTypeResponse;
  const SpecialtyTypeListState({required this.specialtyTypeResponse});
  @override
  List<Object> get props => [specialtyTypeResponse];
}