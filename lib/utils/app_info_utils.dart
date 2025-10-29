import 'package:package_info_plus/package_info_plus.dart';

class AppInfoUtil {
  static PackageInfo? _packageInfo;

  /// Initializes and caches the PackageInfo instance
  static Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  /// Get app version (e.g., "1.0.3")
  static String get version => _packageInfo?.version ?? 'Unknown';

  /// Get build number (e.g., "12")
  static String get buildNumber => _packageInfo?.buildNumber ?? 'Unknown';

  /// Get app name
  static String get appName => _packageInfo?.appName ?? 'Unknown';

  /// Get package name (bundle ID)
  static String get packageName => _packageInfo?.packageName ?? 'Unknown';
}
