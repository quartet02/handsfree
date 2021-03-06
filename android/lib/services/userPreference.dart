import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static late SharedPreferences _prefs;
  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static clearAll() async {
    await _prefs.clear();
  }

  static setRecentSearch(List<String> value) {
    _prefs.setStringList('recentSearch', value);
  }

  static getRecentSearch() {
    if (_prefs.containsKey('recentSearch')) {
      return _prefs.getStringList('recentSearch');
    } else {
      return [];
    }
  }

  static setValue(String key, String value) {
    _prefs.setString(key, value);
  }

  static get(String key) {
    if (_prefs.containsKey(key)) {
      // print("Got this from SharedPreference: ${_prefs.getString(key)}");
      return _prefs.getString(key);
    } else {
      // print("Dont have this thing with this key : $key");
      return [];
    }
  }
}
