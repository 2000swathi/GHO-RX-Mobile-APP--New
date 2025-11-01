import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';

class GetFileIDReo {
  final DioHandler _dioHandler = DioHandler();

  /// Step 1: Get File ID from backend
  Future<Map<String, dynamic>> getFileID(
    String caseID,
    int docTypeID,
    String fileName,
    String fileSize,
  ) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token == null ||
        token.isEmpty ||
        reviewerId == null ||
        reviewerId.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "filemgr", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": caseID},
        {"T": "c1", "V": docTypeID},
        {"T": "c2", "V": fileName},
        {"T": "c3", "V": fileSize},
        {"T": "c10", "V": "1"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception("Error fetching File ID: $e");
    }
  }

  /// Step 2: Get AWS Upload URL from backend
  Future<Map<String, dynamic>?> getUploadUrl({
    required String fileID,
    required String fileType,
  }) async {
    try {
      final url = Uri.parse(
        "https://ghoapps.com/api/file/upload-url?filename=$fileID&filetype=$fileType",
      );
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return {"UploadUrl": data['Url']};
      } else {
        debugPrint("❌ Failed to get upload URL: ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("❌ Exception in getUploadUrl: $e");
      return null;
    }
  }

  /// Step 3: Upload file directly to S3
  Future<bool> uploadFileToS3(
    BuildContext context,
    String url,
    String filePath,
  ) async {
    try {
      final file = File(filePath);

      if (!file.existsSync()) {
        CustomScaffoldMessenger.showErrorMessage(
          context,
          "File not found at $filePath",
        );
        return false;
      }

      final fileBytes = await file.readAsBytes();
      final contentType =
          lookupMimeType(filePath) ?? 'application/octet-stream';

      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': contentType, 'Accept': "*/*"},
        body: fileBytes,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 409) {
        CustomScaffoldMessenger.showErrorMessage(
          context,
          "File already exists",
        );
        return false;
      } else {
        CustomScaffoldMessenger.showErrorMessage(
          context,
          "Upload failed: ${response.statusCode}",
        );
        return false;
      }
    } catch (e) {
      CustomScaffoldMessenger.showErrorMessage(context, e.toString());
      return false;
    }
  }
}
