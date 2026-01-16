part of 'list_bloc.dart';

sealed class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class FetchCountryList extends ListEvent {}

class FetchSpecialtyList extends ListEvent {}

class FetchLicenseList extends ListEvent {}

// class FetchAccrediationList extends ListEvent {}

class FetchCertifiedList extends ListEvent {}

class FetchSpecialtyTypeList extends ListEvent {}

class FetchIssueingAuthorityList extends ListEvent {}

class FetchLangList extends ListEvent {}

class FetchQuestList extends ListEvent {}

class FetchEducationList extends ListEvent {}

class FetchDocTypeList extends ListEvent {}

class FetchReferenceList extends ListEvent {}
