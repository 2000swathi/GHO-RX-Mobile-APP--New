part of 'date_range_bloc.dart';

sealed class DateRangeState extends Equatable {
  const DateRangeState();
  
  @override
  List<Object> get props => [];
}

final class DateRangeInitial extends DateRangeState {}

// Loading state
class DateListPageLoading extends DateRangeState {}



//datelist
class DateRangeInfoState extends DateRangeState {
  final Map<String, dynamic> response;

  const DateRangeInfoState({required this.response});

  @override
  List<Object> get props => [response];
}

class ListPageError extends DateRangeState {
  final String message;

  const ListPageError({required this.message});

  @override
  List<Object> get props => [message];
}
