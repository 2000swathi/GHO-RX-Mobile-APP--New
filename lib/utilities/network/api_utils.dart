import 'package:ghorx_mobile_app_new/utilities/network/lts_and_mode.dart';

class ApiUtils {
  static Map<String, dynamic> getCommonParams({
    required String action,
    required String token,
  }) {
    return {
      "Token": token,
      "Action": action,
      "Mode": "GHORX",
      "Lts": getFormattedLts(),
      "BrowseInfo": getDeviceType(),
    };
  }
}

