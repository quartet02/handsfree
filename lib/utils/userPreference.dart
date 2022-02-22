import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static late SharedPreferences _prefs;

  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static clearAll() async {
    await _prefs.clear();
  }

  static setRecentSearch(List<String> value){
    _prefs.setStringList('recentSearch', value);
  }

  static getRecentSearch(){
    _prefs.getStringList('recentSearch');
  }
}