import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await remoteConfig.setDefaults({
      'ghorx_android_version': '1.0.0+1',
      'ghorx_ios_version': '1.0.0+1',
      'force_update': false,
    });

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 0),
      ),
    );

    await remoteConfig.fetchAndActivate();
  }

  String getLatestVersion() {
    if (Platform.isAndroid) {
      return remoteConfig.getString('ghorx_android_version');
    } else {
      return remoteConfig.getString('ghorx_ios_version');
    }
  }

  bool getForceUpdate() {
    return remoteConfig.getBool('force_update');
  }

  Future<String> getCurrentFullVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return "${packageInfo.version}+${packageInfo.buildNumber}";
  }

  /// 🔥 PUBLIC NOW
  bool isUpdateAvailable(String currentVersion, String latestVersion) {
    try {
      List<int> currentParts =
          currentVersion
              .replaceAll("+", ".")
              .split('.')
              .map((e) => int.parse(e))
              .toList();

      List<int> latestParts =
          latestVersion
              .replaceAll("+", ".")
              .split('.')
              .map((e) => int.parse(e))
              .toList();

      int maxLength =
          currentParts.length > latestParts.length
              ? currentParts.length
              : latestParts.length;

      for (int i = 0; i < maxLength; i++) {
        int currentPart = i < currentParts.length ? currentParts[i] : 0;
        int latestPart = i < latestParts.length ? latestParts[i] : 0;

        if (currentPart < latestPart) return true;
        if (currentPart > latestPart) return false;
      }

      return false;
    } catch (_) {
      return false;
    }
  }
}
