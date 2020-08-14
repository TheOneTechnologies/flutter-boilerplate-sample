import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {

  // store boolean preference data
  static void storeBoolPrefData(String key, bool res) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, res);
  }

  // get boolean preference data
  static Future<bool> getBoolPrefData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool b = prefs.getBool(key) ?? false;
    return b;
  }

  // store string preference data
  static void storeStringPrefData(String key, String res) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, res);
  }

  // retrieve string preference data
  static Future<String> getStringPrefData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = prefs.getString(key) ?? '';
    return str;
  }

  // clear all preference data
  static void clearPrefData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}