part of 'open_closed_bloc.dart';

sealed class OpenClosedEvent extends Equatable {
  const OpenClosedEvent();

  @override
  List<Object> get props => [];
}
//open cases
class FetchOpenCases extends OpenClosedEvent {}
//closedcases
class FetchClosedCases extends OpenClosedEvent {}


