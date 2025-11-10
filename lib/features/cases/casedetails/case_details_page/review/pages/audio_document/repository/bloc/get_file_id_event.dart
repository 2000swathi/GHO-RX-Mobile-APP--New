import 'package:flutter/material.dart';

abstract class GetEvent {}

/// Step 1: Get File ID
class GetFileIdEvent extends GetEvent {
  final String caseID;
  final int docTypeID;
  final String filename;
  final String fileSize;
  final String filePath;
  final String saltKey;
  final BuildContext context;

  GetFileIdEvent({
    required this.caseID,
    required this.docTypeID,
    required this.filename,
    required this.fileSize,
    required this.filePath,
    required this.saltKey,
    required this.context,
  });
}

/// Step 2: Get Upload URL
class GetUploadUrlEvent extends GetEvent {
  final String fileID;
  final String fileType;
  final BuildContext context;
  final String filePath;
  final String caseID;
  final String fileUploadedID;
  final String saltKey;
  final int docTypeID;

  GetUploadUrlEvent({
    required this.fileID,
    required this.fileType,
    required this.context,
    required this.filePath,
    required this.caseID,
    required this.fileUploadedID,
    required this.saltKey,
    required this.docTypeID,
  });
}

/// Step 3: Upload File to S3
class UploadFileToS3Event extends GetEvent {
  final BuildContext context;
  final String url;
  final String filePath;
  final String caseID;
  final int docTypeID;
  final String saltKey;
  final String fileUploadedID;

  UploadFileToS3Event({
    required this.context,
    required this.url,
    required this.filePath,
    required this.caseID,
    required this.docTypeID,
    required this.saltKey,
    required this.fileUploadedID,
  });
}

class DeleteFileEvent extends GetEvent {
  final BuildContext context;
  final String caseID;
  final int docTypeId;
  final int fileUploadedID;
  final String filePath;

  DeleteFileEvent({
    required this.caseID,
    required this.docTypeId,
    required this.fileUploadedID,
    required this.filePath,
    required this.context,
  });
}

class SuccessApiEvent extends GetEvent {
  final String caseID;
  final int docTypeID;
  final String fileUploadedID;
  final String status;
  final String filePath;
   final String saltKey;
  final BuildContext context;

  SuccessApiEvent({
    required this.caseID,
    required this.docTypeID,
    required this.fileUploadedID,
    required this.status,
    required this.filePath,
      required this.saltKey,
    required this.context,
  });
}
