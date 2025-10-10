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
  final List<CountryResponseModel> countryResponse;

  const CountryState({required this.countryResponse});

  @override
  List<Object> get props => [countryResponse];
}



class ListFailure extends ListState {
  final String error;

  const ListFailure({required this.error});

  @override
  List<Object> get props => [error];
}
