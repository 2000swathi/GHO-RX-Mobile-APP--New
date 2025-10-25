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

//License
class LicenseListState extends ListState {
  final LicenseListResponseModel licenseResponse;
  const LicenseListState({required this.licenseResponse});
  @override
  List<Object> get props => [licenseResponse];
}


class ListFailure extends ListState {
  final String error;

  const ListFailure({required this.error});

  @override
  List<Object> get props => [error];
}
