import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileCompressor {
  static Future<File> compressImage(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);

      if (image == null) return file;

      final compressed = img.encodeJpg(image, quality: 80);

      final dir = await getTemporaryDirectory();
      final newPath = p.join(
        dir.path,
        "compressed_${DateTime.now().millisecondsSinceEpoch}.jpg",
      );

      final compressedFile = File(newPath);
      await compressedFile.writeAsBytes(compressed);

      return compressedFile;
    } catch (e) {
      return file;
    }
  }
}
