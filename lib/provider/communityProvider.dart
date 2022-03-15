import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/communityModel.dart';

var communityData = [
  {
    "id": 001,
    "communityTitle": "Ming",
    "communityDesc": "Ming",
    "images": "assets/image/dummy_cat.png",
  },
  {
    "id": 002,
    "communityTitle": "Bruh",
    "communityDesc": "Bruh",
    "images": 'assets/image/dummy_cat.png',
  },
  {
    "id": 003,
    "communityTitle": "Shuaige",
    "communityDesc": "Shuaige",
    "images": 'assets/image/dummy_cat.png',
  },
  {
    "id": 004,
    "communityTitle": "Meinv",
    "communityDesc": "Meinv",
    "images": 'assets/image/dummy_cat.png',
  },
  {
    "id": 005,
    "communityTitle": "Diaoni",
    "communityDesc": "Diaoni",
    "images": 'assets/image/dummy_cat.png',
  },
];

class CommunityProvider with ChangeNotifier {
  List<CommunityModel> communities = communityData
      .map(
        (item) => CommunityModel(
      item['id'],
      item['communityTitle'] ?? "",
      item['communityDesc'] ?? "",
      item['images'] ?? "",
    ),
  )
      .toList();

  List<CommunityModel> get cardDetails {
    return [...communities];
  }
}