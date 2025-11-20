import 'package:url_launcher/url_launcher.dart';

class Links {
  Future<void> privacyPolicy() async {
    const String link = "https://globalhealthopinion.com/privacy-policy";
    await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
  }
}
