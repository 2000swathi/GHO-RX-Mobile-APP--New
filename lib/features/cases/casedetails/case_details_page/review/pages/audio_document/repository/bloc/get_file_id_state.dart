part of 'get_file_id_bloc.dart';

sealed class GetFileIdState extends Equatable {
  const GetFileIdState();

  @override
  List<Object> get props => [];
}

final class GetFileIdInitial extends GetFileIdState {}

final class GetFileIdLoading extends GetFileIdState {}

final class GetFileIdSuccess extends GetFileIdState {
  final Map<String, dynamic> response;
  const GetFileIdSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

final class GetUploadUrlSuccess extends GetFileIdState {
  final Map<String, dynamic> response;
  const GetUploadUrlSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

final class GetFileIdFailure extends GetFileIdState {
  final String message;

  const GetFileIdFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class FileUploadSuccess extends GetFileIdState {
  const FileUploadSuccess();
}
