import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/newsFeedModel.dart';

class NewsFeedProvider with ChangeNotifier {
  String queryText = "";
  List<NewsFeedModel> newsFeeds = newsFeedData
      .map(
        (item) => NewsFeedModel(
          item['newsFeedId'],
          item['newsFeedTitle'] ?? "",
          item['newsFeedDesc'] ?? "",
          item['newsFeedImages'] ?? "",
          item['timestamp'] ?? Timestamp.now(),
          item['author'] ?? "",
          item['authorPic'] ?? "",
        ),
      )
      .toList();

  void setNewsFeedModel(List<NewsFeedModel> newNewsFeed) {
    newsFeeds = newNewsFeed;
  }

  List<NewsFeedModel> get cardDetails {
    return [...newsFeeds];
  }

  String get getQuery {
    return queryText;
  }

  set query(String newQuery) {
    queryText = newQuery;

    notifyListeners();
  }
}

var newsFeedData = [
  {
    "newsFeedId": 001,
    "newsFeedTitle": "Ming",
    "newsFeedDesc": "Ming",
    "newsFeedImages": "assets/image/dummy_cat.png",
    "authorPic": "assets/image/dummy_cat.png",
    "author": "WeiXin",
    "timestamp": Timestamp.now(),
  },
  {
    "newsFeedId": 002,
    "newsFeedTitle": "Bruh",
    "newsFeedDesc": "Bruh",
    "authorPic": "assets/image/dummy_cat.png",
    "newsFeedImages": 'assets/image/dummy_cat.png',
    "author": "WeiXin",
    "timestamp": Timestamp.now(),
  },
  {
    "newsFeedId": 003,
    "newsFeedTitle": "Shuaige",
    "newsFeedDesc": "Shuaige",
    "authorPic": "assets/image/dummy_cat.png",
    "newsFeedImages": 'assets/image/dummy_cat.png',
    "author": "WeiXin",
    "timestamp": Timestamp.now(),
  },
  {
    "newsFeedId": 004,
    "newsFeedTitle": "Meinv",
    "authorPic": "assets/image/dummy_cat.png",
    "newsFeedImages": 'assets/image/dummy_cat.png',
    "author": "WeiXin",
    "timestamp": Timestamp.now(),
  },
  {
    "newsFeedId": 005,
    "newsFeedTitle": "Diaoni",
    "newsFeedDesc": "Diaoni",
    "authorPic": "assets/image/dummy_cat.png",
    "newsFeedImages": 'assets/image/dummy_cat.png',
    "author": "WeiXin",
    "timestamp": Timestamp.now(),
  },
];
