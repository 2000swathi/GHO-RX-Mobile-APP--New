import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openEmailInbox() async {
  if (Platform.isAndroid) {
    // OPEN GMAIL APP SAFE (DOES NOT CLOSE YOUR APP)
    const gmailHome = AndroidIntent(
      action: 'android.intent.action.MAIN',
      category: 'android.intent.category.APP_EMAIL',
      package: 'com.google.android.gm',
      flags: <int>[
        0x10000000, // FLAG_ACTIVITY_NEW_TASK
      ],
    );
    try {
      await gmailHome.launch();
      return;
    } catch (_) {}

    // Gmail inbox intent
    const gmailInboxIntent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.google.android.gm',
      data: 'content://com.google.android.gm.inbox',
      flags: <int>[
        0x10000000, // FLAG_ACTIVITY_NEW_TASK
      ],
    );
    try {
      await gmailInboxIntent.launch();
      return;
    } catch (_) {}

    // Email chooser
    final emailUri = Uri.parse("mailto:");
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      return;
    }

    // Web fallback
    final gmailWeb = Uri.parse("https://mail.google.com/mail/u/0/#inbox");
    await launchUrl(gmailWeb, mode: LaunchMode.inAppBrowserView);
    return;
  }

  // ----------------------------
  // iOS
  // ----------------------------
  if (Platform.isIOS) {
    final gmailInbox = Uri.parse("googlegmail://inbox");
    if (await canLaunchUrl(gmailInbox)) {
      await launchUrl(gmailInbox);
      return;
    }

    final appleMail = Uri.parse("message://");
    if (await canLaunchUrl(appleMail)) {
      await launchUrl(appleMail);
      return;
    }

    final gmailWeb = Uri.parse("https://mail.google.com/mail/u/0/#inbox");
    await launchUrl(gmailWeb, mode: LaunchMode.externalApplication);
  }
}
