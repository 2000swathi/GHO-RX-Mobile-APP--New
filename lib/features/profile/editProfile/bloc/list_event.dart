part of 'list_bloc.dart';

sealed class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class FetchCountryList extends ListEvent {}

class FetchSpecialtyList extends ListEvent {}

class FetchLicenseList extends ListEvent {}

class FetchLanguageList extends ListEvent {}

class FetchAccrediationList extends ListEvent {}

class FetchCertifiedList extends ListEvent {}

class FetchSpecialtyTypeList extends ListEvent {}


