part of 'doctfile_bloc.dart';

sealed class DoctfileState extends Equatable {
  const DoctfileState();
  
  @override
  List<Object> get props => [];
}

final class DoctfileInitial extends DoctfileState {}
class DoctfileLoading extends DoctfileState {}
class DoctfileSuccess extends DoctfileState {
  final Map<String, dynamic> response;

  const DoctfileSuccess({required this.response});

  @override
  List<Object> get props => [response];
}
class DoctfileFailure extends DoctfileState {
  final String error;

  const DoctfileFailure({required this.error});

  @override
  List<Object> get props => [error];
}
