part of 'get_file_id_bloc.dart';

sealed class GetFileIdState extends Equatable {
  const GetFileIdState();

  @override
  List<Object> get props => [];
}

final class GetFileIdInitial extends GetFileIdState {}

final class GetFileIdLoading extends GetFileIdState {
  final String filePath;
  const GetFileIdLoading({required this.filePath});

  @override
  List<Object> get props => [filePath];
}

final class GetFileIdSuccess extends GetFileIdState {
  final Map<String, dynamic> response;
  final String filePath;

  const GetFileIdSuccess({
    required this.response,
    required this.filePath,
  });

  @override
  List<Object> get props => [response, filePath];
}

final class GetUploadUrlSuccess extends GetFileIdState {
  final Map<String, dynamic> response;
  final String filePath;

  const GetUploadUrlSuccess({
    required this.response,
    required this.filePath,
  });

  @override
  List<Object> get props => [response, filePath];
}

final class GetFileIdFailure extends GetFileIdState {
  final String message;
  final String filePath;

  const GetFileIdFailure({
    required this.message,
    required this.filePath,
  });

  @override
  List<Object> get props => [message, filePath];
}

final class FileUploadSuccess extends GetFileIdState {
  final String filePath;
  const FileUploadSuccess({required this.filePath});

  @override
  List<Object> get props => [filePath];
}
