part of 'doctfile_bloc.dart';

sealed class DoctfileEvent extends Equatable {
  const DoctfileEvent();

  @override
  List<Object> get props => [];
}

class UploadDocFileEvent extends DoctfileEvent {}
