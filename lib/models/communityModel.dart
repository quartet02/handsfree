import 'package:flutter/material.dart';

class CommunityModel extends ChangeNotifier {
  dynamic id;
  dynamic communityTitle;
  dynamic communityDesc;
  dynamic images;

  CommunityModel(this.id, this.communityTitle, this.communityDesc, this.images);

  // Map<String, Object> getData(int index) {
  //   return communityData[index];
  // }

}
