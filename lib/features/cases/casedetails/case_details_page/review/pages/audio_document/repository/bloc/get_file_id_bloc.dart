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
          event.saltKey,
        );

        if (response["Data"] != null &&
            response["Data"][0] != null &&
            response["Data"][0][0] != null &&
            response["Data"][0][0]["id"] != null) {
          emit(GetFileIdSuccess(response: response, filePath: event.filePath));

          final String fileID = response["Data"][0][0]["fid"].toString();
          final String fileType = response["Data"][0][0]["ftype"] ?? "";
          final String fileUploadedID = response["Data"][0][0]["id"] ?? "";

          // Step 2: Automatically trigger get upload URL
          add(
            GetUploadUrlEvent(
              fileID: fileID,
              fileType: fileType,
              filePath: event.filePath,
              context: event.context,
              caseID: event.caseID,
              docTypeID: event.docTypeID,
              saltKey: event.saltKey,
              fileUploadedID: fileUploadedID,
            ),
          );
        } else {
          emit(
            GetFileIdFailure(
              message: response["Info"] ?? "Failed to get file ID",
              filePath: event.filePath,
            ),
          );
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
          emit(
            GetUploadUrlSuccess(
              response: uploadResponse,
              filePath: event.filePath,
            ),
          );

          // Step 3: Trigger upload
          add(
            UploadFileToS3Event(
              context: event.context,
              url: uploadResponse["UploadUrl"],
              filePath: event.filePath,
              caseID: event.caseID,
              docTypeID: event.docTypeID,
              saltKey: event.saltKey,
              fileUploadedID: event.fileUploadedID,
            ),
          );
        } else {
          emit(
            GetFileIdFailure(
              message: "Failed to get upload URL",
              filePath: event.filePath,
            ),
          );
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
          add(
            SuccessApiEvent(
              caseID: event.caseID,
              docTypeID: event.docTypeID,
              fileUploadedID: event.fileUploadedID,
              status: "2",
              filePath: event.filePath,
              saltKey: event.saltKey,
              context: event.context,
            ),
          );
        } else {
          add(
            SuccessApiEvent(
              caseID: event.caseID,
              docTypeID: event.docTypeID,
              fileUploadedID: event.fileUploadedID,
              status: "3",
              filePath: event.filePath,
              saltKey: event.saltKey,
              context: event.context,
            ),
          );
        }
      } catch (e) {
        emit(GetFileIdFailure(message: e.toString(), filePath: event.filePath));
      }
    });

    //success
    on<SuccessApiEvent>((event, emit) async {
      emit(GetFileIdLoading(filePath: event.filePath));
      try {
        final response = await repository.successApi(
          event.caseID,
          event.docTypeID,
          event.fileUploadedID,
          event.status,
          event.saltKey,
        );

        if (response["Status"] == 1) {
          emit(SuccessAPI(filePath: event.filePath));
          CustomScaffoldMessenger.showSuccessMessage(
            event.context,
            "File uploaded successfully",
          );
        } else {
          emit(
            GetFileIdFailure(
              message: response["Info"] ?? "File Upload Failed",
              filePath: event.filePath,
            ),
          );
        }
      } catch (e) {
        emit(GetFileIdFailure(message: e.toString(), filePath: event.filePath));
      }
    });
    // delete
    on<DeleteFileEvent>((event, emit) async {
      emit(GetFileIdLoading(filePath: event.filePath));
      try {
        final response = await repository.deleteFile(
          event.saltID,
          event.docTypeId,
          event.fileUploadedID,
        );

        if (response["Status"] == 1) {
          if (response["Data"] != null &&
              response["Data"][0] != null &&
              response["Data"][0][0] != null &&
              response["Data"][0][0]["msg"] != null) {
            emit(DeleteFileSuccess(response: response));
            CustomScaffoldMessenger.showSuccessMessage(
              event.context,
              response["Data"][0][0]["msg"],
            );
          }
        } else {
          emit(
            GetFileIdFailure(
              message: response["Info"],
              filePath: event.filePath,
            ),
          );
        }
      } catch (e) {
        emit(GetFileIdFailure(message: e.toString(), filePath: event.filePath));
      }
    });
  }
}
