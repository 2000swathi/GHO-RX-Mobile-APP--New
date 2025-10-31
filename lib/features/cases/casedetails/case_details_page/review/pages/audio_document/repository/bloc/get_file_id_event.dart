import 'package:flutter/material.dart';

abstract class GetEvent {}

/// Step 1: Get File ID
class GetFileIdEvent extends GetEvent {
  final String caseID;
  final int docTypeID;
  final String filename;
  final String fileSize;
  final String filePath;
  final BuildContext context;

  GetFileIdEvent({
    required this.caseID,
    required this.docTypeID,
    required this.filename,
    required this.fileSize,
    required this.filePath,
    required this.context
  });
}

/// Step 2: Get Upload URL
class GetUploadUrlEvent extends GetEvent {
  final String fileID;
  final String fileType;
  final BuildContext context;
  final String filePath;

  GetUploadUrlEvent({
    required this.fileID,
    required this.fileType,
    required this.context,
    required this.filePath
  });
}

/// Step 3: Upload File to S3
class UploadFileToS3Event extends GetEvent {
  final BuildContext context;
  final String url;
  final String filePath;

  UploadFileToS3Event({
    required this.context,
    required this.url,
    required this.filePath,
  });
}
