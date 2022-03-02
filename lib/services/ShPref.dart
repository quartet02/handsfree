import 'package:shared_preferences/shared_preferences.dart';

// //save Shared Preference using
// await UserSimplePreferences.setUsername(name);
// await UserSimplePreferences.setTime(time1);
// await UserSimplePreferences.setFriends(friends);
// //Do not forget to initiate variable name = '' at the start of the class

// //after declaring variable, please insert this code to initialize these variable
// String name = '';
// DateTime time1;
// List<String> friends = List.filled(5, '');
//
// @override
// void initState(){
//   super.initState();
// //if null, set as ''
// //String shared preferences
//   name = UserSimplePreferences.getUsername() ?? '';
//
// //DateTime load
// time1 = UserSimplePreferences.getTime();
//
// //Array shared preferences
//   friends = UserSimplePreferences.getFriends() ?? [];
// }

class UserSimplePreferences{
  static late SharedPreferences _preferences;

  static const _keyUsername = 'username';
  static const _keyFriends = 'friends';
  static const _keyTime = 'time1';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);

  static String? getUsername() => _preferences.getString(_keyUsername);

  static Future setFriends(List<String> friends) async =>
      await _preferences.setStringList(_keyFriends, friends);

  static List<String>? getFriends() => _preferences.getStringList(_keyFriends);

  static Future setTime(DateTime time1) async{
      final time = time1.toIso8601String();
      return await _preferences.setString(_keyTime, time);

  }

  static DateTime? getTime() {
    final time1 = _preferences.getString(_keyTime);
    return time1 == null ? null : DateTime.tryParse(time1);
  }
}
