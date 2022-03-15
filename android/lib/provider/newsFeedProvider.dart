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
        ),
      )
      .toList();

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
  },
  {
    "newsFeedId": 002,
    "newsFeedTitle": "Bruh",
    "newsFeedDesc": "Bruh",
    "newsFeedImages": 'assets/image/dummy_cat.png',
  },
  {
    "newsFeedId": 003,
    "newsFeedTitle": "Shuaige",
    "newsFeedDesc": "Shuaige",
    "newsFeedImages": 'assets/image/dummy_cat.png',
  },
  {
    "newsFeedId": 004,
    "newsFeedTitle": "Meinv",
    "newsFeedDesc": "Meinv",
    "newsFeedImages": 'assets/image/dummy_cat.png',
  },
  {
    "newsFeedId": 005,
    "newsFeedTitle": "Diaoni",
    "newsFeedDesc": "Diaoni",
    "newsFeedImages": 'assets/image/dummy_cat.png',
  },
];
