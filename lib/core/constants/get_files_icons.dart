import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';

class GetFilesandIcons {
  static String getFileIcon(String? fileName) {
    if (fileName == null) return "assets/svg/Files Icons.svg";

    final lower = fileName.toLowerCase();

    if (lower.endsWith(".pdf")) {
      return "assets/svg/pdfIcons.svg";
    } else if (lower.endsWith(".doc")) {
      return "assets/svg/doc_icon.svg";
    } else if (lower.endsWith(".docx")) {
      return "assets/svg/docx_file.svg";
    } else if (lower.endsWith(".xls")) {
      return "assets/svg/xls_icon.svg";
    } else if (lower.endsWith(".xlsx")) {
      return "assets/svg/xlsx_icon.svg";
    } else if (lower.endsWith(".img")) {
      return "assets/svg/img_icon.svg";
    } else if (lower.endsWith(".jpg")) {
      return "assets/svg/jpg_icon.svg";
    } else if (lower.endsWith(".jpeg")) {
      return "assets/svg/jpeg_icon.svg";
    } else if (lower.endsWith(".png")) {
      return "assets/svg/img_icon.svg";
    } else {
      return "assets/svg/Files Icons.svg";
    }
  }

  static Future<void> openDocument(String url) async {
    if (url.isEmpty) return;

    final lower = url.toLowerCase();

    // ✅ Use Google Docs Viewer for Word/PDF files
    if (lower.endsWith(".pdf") ||
        lower.endsWith(".doc") ||
        lower.endsWith(".docx")) {
      final googleDocsUrl =
          'https://docs.google.com/gview?embedded=true&url=$url';
      final uri = Uri.parse(googleDocsUrl);
      if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
        throw Exception('Could not open $googleDocsUrl');
      }
    } else {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
        throw Exception('Could not open $url');
      }
    }
  }
}
