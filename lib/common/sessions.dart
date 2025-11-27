import 'package:my_cmh_updated/common/shared_pref_key.dart';
import 'package:my_cmh_updated/common/string_pref_key.dart';
import 'package:my_cmh_updated/config/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static final Session _singleton = Session._internal();
  static Session get shared => _singleton;
  factory Session() {
    return _singleton;
  }
  Session._internal();

  getSlotData() async {
    final SharedPreferences prefs = await _prefs;
    var tk = prefs.getString(SharedPreferenceKeys.slotNo) ?? "";
    print("🍎 slotNo from box! $tk");
    StringPreferenceKeys.slotNo = tk;
    return tk;
  }

  saveSlotDate(String newToken) async {
    final SharedPreferences prefs = await _prefs;
    StringPreferenceKeys.slotNo = newToken;
    prefs.setString(SharedPreferenceKeys.slotNo, newToken);
    print("🍎saved slotNo to box! $newToken");
  }

  clearSlotDate() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(SharedPreferenceKeys.slotNo);
    print("🍎delete slotNo");
  }

  getUserId() async {
    final SharedPreferences prefs = await _prefs;
    var tk = prefs.getString(SharedPreferenceKeys.userId) ?? "";
    print("🍎 userId from box! $tk");
    StringPreferenceKeys.userId = tk;
    //return AppConfig.isProduction ? tk : tk;
    return 'BD-000000';
  }

  saveUserId(String userId) async {
    final SharedPreferences prefs = await _prefs;
    StringPreferenceKeys.userId = userId;
    prefs.setString(SharedPreferenceKeys.userId, userId);
    print("🍎saved userId to box! $userId");
  }

  clearUserId() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(SharedPreferenceKeys.userId);
    print("🍎delete userId");
  }
}
