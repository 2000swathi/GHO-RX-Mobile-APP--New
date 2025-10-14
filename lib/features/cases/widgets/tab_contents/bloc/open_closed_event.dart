part of 'open_closed_bloc.dart';

sealed class OpenClosedEvent extends Equatable {
  const OpenClosedEvent();

  @override
  List<Object> get props => [];
}

class FetchOpenCases extends OpenClosedEvent {}
