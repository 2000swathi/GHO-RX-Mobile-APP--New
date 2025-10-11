part of 'list_bloc.dart';

sealed class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class FetchCountryList extends ListEvent {}
class FetchSpecialtyList extends ListEvent {}
