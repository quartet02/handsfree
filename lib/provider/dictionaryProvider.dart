import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handsfree/services/userPreference.dart';

import '../models/wordModel.dart';
import 'package:flutter/material.dart';

class DictionaryProvider extends ChangeNotifier {
  final List? wordData;

  List<WordModel> _wordList = [];
  String _query = '';
  List<WordModel> _suggestion = [];
  static List<String> _history = [];
  static const int _historyLength = 5;
  static late final Map<String, int> _wordCode = {};

  DictionaryProvider({this.wordData}) {
    _wordList = wordData!.asMap().entries.map((e) {
      _wordCode[e.value['word'] as String] = e.key;

      return WordModel(
          word: e.value['word'] as String,
          imgUrl: e.value['imgUrl'] as String,
          definition: e.value['definition'] as String,
          phoneticSymbol: e.value['phoneticSymbol'] as String);
    }).toList();

    var k = UserPreference.getRecentSearch();
    if (k.length >= 1) {
      _history = k;
    }
  }

  List<WordModel> get words {
    return [..._wordList];
  }

  set query(String newQuery) {
    _query = newQuery;
    updateSuggestion(_query);
  }

  set words(List<WordModel> newData) {
    _wordList = newData;
    notifyListeners();
  }

  String get getQuery {
    return _query;
  }

  List<String> get history {
    return _history;
  }

  List<WordModel> get suggestion {
    return _suggestion;
  }

  // save word
  void addSearchTerm(String term) {
    if (_history.contains(term)) {
      deleteSearchTerm(term);
    }
    _history.insert(0, term);
    if (_history.length > _historyLength) {
      _history.removeLast();
    }
    UserPreference.setRecentSearch(_history);
    notifyListeners();
  }

  void deleteSearchTerm(String term) {
    _history.removeWhere((t) => t == term);
    UserPreference.setRecentSearch(_history);
    notifyListeners();
  }

  void updateSuggestion(String query) {
    if (query.isEmpty) {
      if (_history.isNotEmpty) {
        _suggestion =
            _history.map((e) => _wordList[_wordCode[e] as int]).toList();
      } else {
        _suggestion = [];
      }
    } else {
      _suggestion = _wordList
          .map((wordObject) {
            // case insensitive search
            if (wordObject.word.toUpperCase().startsWith(query.toUpperCase())) {
              return wordObject;
            } else {
              // return empty Word
              return WordModel(
                  word: "", imgUrl: "", definition: "", phoneticSymbol: "");
            }
          })
          .toList()
          .cast<WordModel>();
      // clean up the list
      _suggestion.removeWhere((element) => element.word == "");
      if (_suggestion.length > 5) {
        _suggestion = _suggestion.sublist(0, _historyLength);
      }
    }

    notifyListeners();
  }
}
