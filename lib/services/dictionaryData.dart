import 'package:handsfree/utils/userPreference.dart';

class DictionaryData {
  final List<String> phrases;
  static List<String> recentSearch = UserPreference.getRecentSearch() ?? [];
  static int historyLength = 5;

  DictionaryData({required this.phrases});

  List<String> getSuggestions(String query) {
    if (query.isEmpty) {
      return recentSearch;
    } else {
      return phrases.where((element) => element.startsWith(query)).toList();
    }
  }

  List getPhrases() {
    return phrases;
  }

  void addSearchTerm(String term) {
    if (recentSearch.contains(term)) {
      deleteSearchTerm(term);
    }
    recentSearch.insert(0, term);
    if (recentSearch.length > historyLength) {
      recentSearch.removeLast();
    }
    UserPreference.setRecentSearch(recentSearch);
  }

  void deleteSearchTerm(String term) {
    recentSearch.removeWhere((t) => t == term);
    UserPreference.setRecentSearch(recentSearch);
  }
}

