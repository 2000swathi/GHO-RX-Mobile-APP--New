import 'dart:io';
import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class FileHelper {
  static Future<void> openRemoteFile(String url, String fileName) async {
    try {
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);

      // ✅ Download the file
      if (!await file.exists()) {
        final response = await Dio().download(url, filePath);
        if (response.statusCode == 200) {
        }
      }

      // ✅ Open the file using OpenFilex
      await OpenFilex.open(filePath);
    } catch (e) {
      rethrow;
    }
  }
}
