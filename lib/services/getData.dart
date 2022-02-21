import 'package:firebase_core/firebase_core.dart';

class getData {
  static String? _username;
  static String? _userId;

  static List<String> phrases = [];

  static List<String> recentSearch = [];

  static Future<int> load() async {
    // code to load user data from firebase

    // mock load
    phrases.clear();
    recentSearch.clear();
    print("cleared");
    final toLoad = [
      "hi",
      "hello",
      "nice to meet you",
      "you",
      "where",
      "what to do",
    ];
    _username = "Test";
    _userId = "12345678sdfgh5678";
    phrases.addAll(toLoad);
    recentSearch.addAll(["nice to meet you", "you"]);
    print('reloaded');
    return 1;
  }

  static List<String> getSuggestions(String query) {
    if (query.isEmpty) {
      print('called is empty');
      return recentSearch;
    } else {
      print('called not empty');
      return phrases.where((element) => element.startsWith(query)).toList();
    }
  }

  static List getPhrases() {
    return phrases;
  }
}
