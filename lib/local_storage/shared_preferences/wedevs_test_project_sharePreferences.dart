import 'package:shared_preferences/shared_preferences.dart';

//ignore: avoid_classes_with_only_static_members
class WeDevsTestProjectSharePreferences {
  static late SharedPreferences sharedPrefs;
  static Future<void> initializePrefs() async {
    final sp = await SharedPreferences.getInstance();
    sharedPrefs = sp;
  }

  static Future<SharedPreferences> getInstance() async {
    return SharedPreferences.getInstance();
  }

  static void setString({required String key, required String value}) {
    sharedPrefs.setString(key, value);
  }

  static void setStringList({required String key, required List<String> values}) {
    sharedPrefs.setStringList(key, values);
  }

  static void setInt({required String key, required int value}) {
    sharedPrefs.setInt(key, value);
  }

  static void setDouble({required String key, required double value}) {
    sharedPrefs.setDouble(key, value);
  }

  static void setBool({required String key, required bool value}) {
    sharedPrefs.setBool(key, value);
  }

  static String? getString({required String key}) {
    return sharedPrefs.getString(key);
  }

  static List<String>? getStringList({required String key}) {
    return sharedPrefs.getStringList(key);
  }

  static int? getInt({required String key}) {
    return sharedPrefs.getInt(key);
  }

  static bool? getBool({required String key}) {
    return sharedPrefs.getBool(key);
  }

  static double? getDouble({required String key}) {
    return sharedPrefs.getDouble(key);
  }

  static void removeKey({required String key}) {
    sharedPrefs.remove(key);
  }

  static bool contains({required String key}) {
    return sharedPrefs.containsKey(key);
  }

  static void clear() {
    sharedPrefs.clear();
  }
}
