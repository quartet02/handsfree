import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/newsFeedModel.dart';

class NewsFeedProvider with ChangeNotifier {
  List<NewsFeedModel> newsFeeds = newsFeedData
      .map(
        (item) => NewsFeedModel(
      item['newsFeedId'],
      item['newsFeedTitle'] ?? "",
      item['newsFeedDesc'] ?? "",
      item['newsFeedImages'] ?? "",
      item['timestamp'] ?? Timestamp.now(),
      item['author'] ?? "",
    ),
  )
      .toList();

  void setNewsFeedModel(List<NewsFeedModel> newNewsFeed){
    newsFeeds = newNewsFeed;
  }

  List<NewsFeedModel> get cardDetails {
    return [...newsFeeds];
  }
}

var newsFeedData = [
  {
    "newsFeedId": 001,
    "newsFeedTitle": "Ming",
    "newsFeedDesc": "Ming",
    "newsFeedImages": "assets/image/dummy_cat.png",
    "author": "WeiXin",
    "timestamp": Timestamp.now(),
  },
  {
    "newsFeedId": 002,
    "newsFeedTitle": "Bruh",
    "newsFeedDesc": "Bruh",
    "newsFeedImages": 'assets/image/dummy_cat.png',
    "author": "WeiXin",
    "timestamp": Timestamp.now(),
  },
  {
    "newsFeedId": 003,
    "newsFeedTitle": "Shuaige",
    "newsFeedDesc": "Shuaige",
    "newsFeedImages": 'assets/image/dummy_cat.png',
    "author": "WeiXin",
    "timestamp": Timestamp.now(),
  },
  {
    "newsFeedId": 004,
    "newsFeedTitle": "Meinv",
    "newsFeedDesc": "Meinv",
    "newsFeedImages": 'assets/image/dummy_cat.png',
    "author": "WeiXin",
    "timestamp": Timestamp.now(),
  },
  {
    "newsFeedId": 005,
    "newsFeedTitle": "Diaoni",
    "newsFeedDesc": "Diaoni",
    "newsFeedImages": 'assets/image/dummy_cat.png',
    "author": "WeiXin",
    "timestamp": Timestamp.now(),
  },
];