class TextFormatter {
  static String formatFileName(String fileName) {
    try {
      final parts = fileName.split('.');
      if (parts.length < 2) return fileName;

      final extension = parts.last;
      final nameWithoutExt = parts.sublist(0, parts.length - 1).join('.');

      // Split by underscore
      final nameParts = nameWithoutExt.split('_');

      // Take only first 3 parts (adjust if needed)
      final shortName = nameParts.take(3).join('_');

      return "$shortName...$extension";
    } catch (e) {
      return fileName;
    }
  }
}
