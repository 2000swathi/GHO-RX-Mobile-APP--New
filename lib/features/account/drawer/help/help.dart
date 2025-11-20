import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/send%20mail/send_message.dart';

class HelpScrn extends StatelessWidget {
  const HelpScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return SendMessage(from: "nandhana@gmail.com", to: "admin@gho.care");
  }
}
