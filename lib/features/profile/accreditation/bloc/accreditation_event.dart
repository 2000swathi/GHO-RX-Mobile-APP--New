part of 'accreditation_bloc.dart';

sealed class AccreditationEvent extends Equatable {
  const AccreditationEvent();

  @override
  List<Object> get props => [];
}

class FetchAccreditation extends AccreditationEvent {}
