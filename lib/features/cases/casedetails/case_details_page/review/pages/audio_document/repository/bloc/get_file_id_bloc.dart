import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/get_file_id_repo.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_event.dart';

part 'get_file_id_state.dart';

class GetFileIdBloc extends Bloc<GetEvent, GetFileIdState> {
  final GetFileIDReo repository;

  GetFileIdBloc({required this.repository}) : super(GetFileIdInitial()) {
    /// Step 1: Get File ID
    on<GetFileIdEvent>((event, emit) async {
      emit(GetFileIdLoading(filePath: event.filePath));
      try {
        final response = await repository.getFileID(
          event.caseID,
          event.docTypeID,
          event.filename,
          event.fileSize,
        );

        if (response["Status"] == 1 && response["Data"]?[0]?[0]?["id"] != null) {
          emit(GetFileIdSuccess(response: response, filePath: event.filePath));

          final String fileID = response["Data"][0][0]["fid"].toString();
          final String fileType = response["Data"][0][0]["ftype"] ?? "";

          // Step 2: Automatically trigger get upload URL
          add(GetUploadUrlEvent(
            fileID: fileID,
            fileType: fileType,
            filePath: event.filePath,
            context: event.context,
          ));
        } else {
          emit(GetFileIdFailure(
            message: response["Info"] ?? "Failed to get file ID",
            filePath: event.filePath,
          ));
        }
      } catch (e) {
        emit(GetFileIdFailure(message: e.toString(), filePath: event.filePath));
      }
    });

    /// Step 2: Get Upload URL
    on<GetUploadUrlEvent>((event, emit) async {
      emit(GetFileIdLoading(filePath: event.filePath));
      try {
        final uploadResponse = await repository.getUploadUrl(
          fileID: event.fileID,
          fileType: event.fileType,
        );

        if (uploadResponse != null && uploadResponse["UploadUrl"] != null) {
          emit(GetUploadUrlSuccess(
              response: uploadResponse, filePath: event.filePath));

          // Step 3: Trigger upload
          add(UploadFileToS3Event(
            context: event.context,
            url: uploadResponse["UploadUrl"],
            filePath: event.filePath,
          ));
        } else {
          emit(GetFileIdFailure(
              message: "Failed to get upload URL", filePath: event.filePath));
        }
      } catch (e) {
        emit(GetFileIdFailure(message: e.toString(), filePath: event.filePath));
      }
    });

    /// Step 3: Upload File to S3
    on<UploadFileToS3Event>((event, emit) async {
      emit(GetFileIdLoading(filePath: event.filePath));
      try {
        final success = await repository.uploadFileToS3(
          event.context,
          event.url,
          event.filePath,
        );

        if (success) {
          emit(FileUploadSuccess(filePath: event.filePath));
          CustomScaffoldMessenger.showSuccessMessage(
            event.context,
            "File uploaded successfully",
          );
        } else {
          emit(GetFileIdFailure(
              message: "File upload failed", filePath: event.filePath));
        }
      } catch (e) {
        emit(GetFileIdFailure(message: e.toString(), filePath: event.filePath));
      }
    });
  }
}
