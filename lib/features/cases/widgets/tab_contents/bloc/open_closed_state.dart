part of 'open_closed_bloc.dart';

sealed class OpenClosedState extends Equatable {
  const OpenClosedState();
  
  @override
  List<Object> get props => [];
}

final class OpenClosedInitial extends OpenClosedState {}
