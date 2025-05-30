import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static final PreferenceManager _instance = PreferenceManager._internal();

  factory PreferenceManager() {
    return _instance;
  }

  PreferenceManager._internal();

  late final SharedPreferences sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    return await sharedPreferences.setString(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await sharedPreferences.setInt(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await sharedPreferences.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await sharedPreferences.setDouble(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await sharedPreferences.setStringList(key, value);
  }

  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  int? getInt(String key) {
    return sharedPreferences.getInt(key);
  }

  bool? getBool(String key) {
    return sharedPreferences.getBool(key);
  }

  double? getDouble(String key) {
    return sharedPreferences.getDouble(key);
  }

  List<String>? getStringList(String key) {
    return sharedPreferences.getStringList(key);
  }

  void remove(String key)async{
    await sharedPreferences.remove(key);
  }

  void clear() async{
    await sharedPreferences.clear();
  }

}
