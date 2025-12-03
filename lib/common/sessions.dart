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

    StringPreferenceKeys.slotNo = tk;
    return tk;
  }

  saveSlotDate(String newToken) async {
    final SharedPreferences prefs = await _prefs;
    StringPreferenceKeys.slotNo = newToken;
    prefs.setString(SharedPreferenceKeys.slotNo, newToken);
  }

  clearSlotDate() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(SharedPreferenceKeys.slotNo);
  }

  getUserId() async {
    final SharedPreferences prefs = await _prefs;
    var tk = prefs.getString(SharedPreferenceKeys.userId) ?? "";

    StringPreferenceKeys.userId = tk;
    return AppConfig.isProduction ? tk : tk;
  }

  saveUserId(String userId) async {
    final SharedPreferences prefs = await _prefs;
    StringPreferenceKeys.userId = userId;
    prefs.setString(SharedPreferenceKeys.userId, userId);
  }

  clearUserId() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(SharedPreferenceKeys.userId);
  }
}
