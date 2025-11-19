part of 'pic_bloc.dart';

sealed class PicState extends Equatable {
  const PicState();

  @override
  List<Object> get props => [];
}

final class PicInitial extends PicState {}

final class PicLoading extends PicState {}

final class PicSuccess extends PicState {
  final Map<String, dynamic> response;

  const PicSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

final class PicFailure extends PicState {
  final String error;

  const PicFailure({required this.error});

  @override
  List<Object> get props => [error];
}
