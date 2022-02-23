import 'package:shared_preferences/shared_preferences.dart';

class Cacth_Helper {
  static late SharedPreferences sharedPreferences;

  static inti() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean(String key, bool value) async {
    return sharedPreferences.setBool(key, value);
  }

  static bool? getBoolean(String key) {
    return sharedPreferences.getBool(key);
  }
  static Future<bool> putLang(String key, String value) async {
    return sharedPreferences.setString(key, value);
  }

  static String? getLang(String key) {
    return sharedPreferences.getString(key);
  }
}
