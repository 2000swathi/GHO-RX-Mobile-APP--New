import 'dart:io';
import 'package:intl/intl.dart';

String getFormattedLts() {
  DateTime now = DateTime.now();
  String timeZoneOffset = formatTimeZoneOffset(now.timeZoneOffset);
  String timeZoneName = now.timeZoneName;

  return "${DateFormat("EEE MMM dd yyyy HH:mm:ss").format(now)} GMT$timeZoneOffset ($timeZoneName)";
}

String formatTimeZoneOffset(Duration offset) {
  String sign = offset.isNegative ? "-" : "+";
  int hours = offset.inHours.abs();
  int minutes = (offset.inMinutes.abs() % 60);
  return "$sign${hours.toString().padLeft(2, '0')}${minutes.toString().padLeft(2, '0')}";
}

void main() {}

String getDeviceType() {
  if (Platform.isAndroid) {
    return "Android";
  } else if (Platform.isIOS) {
    return "iOS";
  } else {
    return "Unknown";
  }
}
