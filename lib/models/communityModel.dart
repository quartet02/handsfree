import 'package:flutter/material.dart';

class CommunityModel {
  dynamic id;
  dynamic communityTitle;
  dynamic communityDesc;
  dynamic images;

  CommunityModel(this.id, this.communityTitle, this.communityDesc, this.images);
}

class CommunityModel_1{
  final content;
  final media;
  final participant;
  final title;

  CommunityModel_1({this.content, this.media, this.participant, this.title});
}