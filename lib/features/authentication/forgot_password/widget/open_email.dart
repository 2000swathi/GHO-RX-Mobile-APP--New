import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openEmailInbox() async {
  try {
    // ---------------- ANDROID ----------------
    if (!kIsWeb && Platform.isAndroid) {
      final Uri emailUri = Uri.parse("mailto:");
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      return;
    }

    // ---------------- iOS ----------------
    if (!kIsWeb && Platform.isIOS) {
      final gmailInbox = Uri.parse("googlegmail://");
      if (await canLaunchUrl(gmailInbox)) {
        await launchUrl(gmailInbox);
        return;
      }

      final appleMail = Uri.parse("message://");
      if (await canLaunchUrl(appleMail)) {
        await launchUrl(appleMail);
        return;
      }

      final gmailWeb = Uri.parse("https://mail.google.com");
      await launchUrl(gmailWeb, mode: LaunchMode.externalApplication);
      return;
    }

    // ---------------- WEB FALLBACK ----------------
    final gmailWeb = Uri.parse("https://mail.google.com");
    await launchUrl(gmailWeb, mode: LaunchMode.externalApplication);
  } catch (e) {
    debugPrint("Error opening email: $e");
  }
}
