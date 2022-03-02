import 'package:flutter/material.dart';
import 'package:handsfree/models/topicsModel.dart';
import 'package:handsfree/screens/learn/mainLearningPage.dart';
import 'package:provider/provider.dart';

var topicData = [
  {
    "contentid": "#00001",
    "title": "Issue 1",
    "Content":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum egestas, eros quis placerat ultricies, erat est finibus lorem, sit amet feugiat nulla nisi id risus. Nulla lacinia dolor maximus dolor lacinia maximus. Integer at urna in est consequat tincidunt a a lectus. Ut leo metus, tincidunt eget consequat sit amet, placerat porttitor nibh. Pellentesque ultricies, ex at tempus semper, ante magna pulvinar mauris, nec dapibus neque lectus a augue. Nam cursus hendrerit scelerisque. Ut molestie feugiat sem efficitur pellentesque. Nam euismod nibh ipsum, non sodales est tempor et. In eget facilisis lorem.",
    "Author": "Author A",
    "readBy": 10,
    "likes": 5,
  },
  {
    "contentid": "#00002",
    "title": "Issue 2",
    "Content":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum egestas, eros quis placerat ultricies, erat est finibus lorem, sit amet feugiat nulla nisi id risus. Nulla lacinia dolor maximus dolor lacinia maximus. Integer at urna in est consequat tincidunt a a lectus. Ut leo metus, tincidunt eget consequat sit amet, placerat porttitor nibh. Pellentesque ultricies, ex at tempus semper, ante magna pulvinar mauris, nec dapibus neque lectus a augue. Nam cursus hendrerit scelerisque. Ut molestie feugiat sem efficitur pellentesque. Nam euismod nibh ipsum, non sodales est tempor et. In eget facilisis lorem.",
    "Author": "Author B",
    "readBy": 7,
    "likes": 6,
  },
  {
    "contentid": "#00003",
    "title": "Big Issue 1",
    "Content":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum egestas, eros quis placerat ultricies, erat est finibus lorem, sit amet feugiat nulla nisi id risus. Nulla lacinia dolor maximus dolor lacinia maximus. Integer at urna in est consequat tincidunt a a lectus. Ut leo metus, tincidunt eget consequat sit amet, placerat porttitor nibh. Pellentesque ultricies, ex at tempus semper, ante magna pulvinar mauris, nec dapibus neque lectus a augue. Nam cursus hendrerit scelerisque. Ut molestie feugiat sem efficitur pellentesque. Nam euismod nibh ipsum, non sodales est tempor et. In eget facilisis lorem.",
    "Author": "Author C",
    "readBy": 4,
    "likes": 4,
  },
  {
    "contentid": "#00004",
    "title": "Big Issue 2",
    "Content":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum egestas, eros quis placerat ultricies, erat est finibus lorem, sit amet feugiat nulla nisi id risus. Nulla lacinia dolor maximus dolor lacinia maximus. Integer at urna in est consequat tincidunt a a lectus. Ut leo metus, tincidunt eget consequat sit amet, placerat porttitor nibh. Pellentesque ultricies, ex at tempus semper, ante magna pulvinar mauris, nec dapibus neque lectus a augue. Nam cursus hendrerit scelerisque. Ut molestie feugiat sem efficitur pellentesque. Nam euismod nibh ipsum, non sodales est tempor et. In eget facilisis lorem.",
    "Author": "Author C",
    "readBy": 5,
    "likes": 3,
  },
  {
    "contentid": "#00005",
    "title": "Big Issue 3",
    "Content":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum egestas, eros quis placerat ultricies, erat est finibus lorem, sit amet feugiat nulla nisi id risus. Nulla lacinia dolor maximus dolor lacinia maximus. Integer at urna in est consequat tincidunt a a lectus. Ut leo metus, tincidunt eget consequat sit amet, placerat porttitor nibh. Pellentesque ultricies, ex at tempus semper, ante magna pulvinar mauris, nec dapibus neque lectus a augue. Nam cursus hendrerit scelerisque. Ut molestie feugiat sem efficitur pellentesque. Nam euismod nibh ipsum, non sodales est tempor et. In eget facilisis lorem.",
    "Author": "Author C",
    "readBy": 7,
    "likes": 1,
  },
  {
    "contentid": "#00006",
    "title": "Small Issue 1",
    "Content":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum egestas, eros quis placerat ultricies, erat est finibus lorem, sit amet feugiat nulla nisi id risus. Nulla lacinia dolor maximus dolor lacinia maximus. Integer at urna in est consequat tincidunt a a lectus. Ut leo metus, tincidunt eget consequat sit amet, placerat porttitor nibh. Pellentesque ultricies, ex at tempus semper, ante magna pulvinar mauris, nec dapibus neque lectus a augue. Nam cursus hendrerit scelerisque. Ut molestie feugiat sem efficitur pellentesque. Nam euismod nibh ipsum, non sodales est tempor et. In eget facilisis lorem.",
    "Author": "Author A",
    "readBy": 7,
    "likes": 0,
  },
];

class HelpDeskProvider extends ChangeNotifier {
  List<TopicModel> _topicList = [];
  List<TopicModel> _suggestions = [];
  late String _queryText = "";
  static late final Map<String, int> _scores = {};

  HelpDeskProvider() {
    _topicList = topicData.asMap().entries.map((e) {
      double scores = ((e.value["readBy"] as int).toDouble()) +
          ((e.value["likes"] as int).toDouble() /
              (e.value["readBy"] as int).toDouble());
      return TopicModel(
          title: e.value["title"] as String,
          content: e.value["Content"] as String,
          author: e.value["Author"] as String,
          score: scores);
    }).toList();
  }

  List get topics {
    if (_suggestions.isEmpty) {
      updateSuggestions();
    }
    return [..._suggestions];
  }

  set query(String query) {
    _queryText = query;
    updateSuggestions();
  }

  // suggested content rank formulaR
  // read + likes/read
  updateSuggestions() {
    // rank ordered
    if (_queryText.isEmpty) {
      _suggestions = _topicList;
      _suggestions.sort(((a, b) => a.score.compareTo(b.score)));
      _suggestions = _suggestions.reversed.toList();
    }
    // according to search query
    else {
      _suggestions = _topicList
          .map((e) {
            if (e.title.toUpperCase().startsWith(_queryText.toUpperCase())) {
              return e;
            } else if (e.content
                .toUpperCase()
                .contains(_queryText.toUpperCase())) {
              return e;
            } else {
              return TopicModel(title: "", content: "", author: "", score: 0);
            }
          })
          .toList()
          .cast<TopicModel>();
      _suggestions.removeWhere((element) => element.title == "");
    }
    notifyListeners();
  }
}
