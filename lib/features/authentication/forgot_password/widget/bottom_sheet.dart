import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';

void showEmailSentBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 55),

            SizedBox(height: 18),

            Text(
              "Email Sent!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "A password reset link has been sent to your registered email address.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                const gmailUrl = "mailto:";
                await launchUrl(Uri.parse(gmailUrl));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarycolor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("Open Gmail",
                  style: AppFonts.textwhite,
                ),
            ),

            SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Close",
                style: AppFonts.textblue.copyWith(
                 fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
