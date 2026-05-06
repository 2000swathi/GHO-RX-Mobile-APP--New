import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateUIHelper {
  static void showUpdateBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true, // ✅ important
    backgroundColor: Colors.transparent, // ✅ for full width design
    builder: (_) {
      return Container(
        width: double.infinity, // ✅ FULL WIDTH
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.system_update, size: 50),
            const SizedBox(height: 10),
            const Text(
              "Update Available",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Please update the app to continue"),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity, // ✅ button full width
              child: ElevatedButton(
                onPressed: openStore,
                child: const Text("Update"),
              ),
            ),
          ],
        ),
      );
    },
  );
}
  static Future<void> openStore() async {
    const androidPackage = "in.globalhealthopinionrx";

    final Uri url =
        Platform.isAndroid
            ? Uri.parse("market://details?id=$androidPackage")
            : Uri.parse("https://apps.apple.com/app/id6737513683");

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
