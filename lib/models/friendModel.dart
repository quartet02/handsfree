class friendsModel {
  String friendName;
  String images;

  friendsModel(this.friendName, this.images);
}

List<friendsModel> get friends {
  return friendData
      .map(
        (item) => friendsModel(
      item['lessonName'] ?? "",
      item['images'] ?? "",
    ),
  )
      .toList();
}

var friendData = [
  {
    "lessonName": "Ming",
    "images": "assets/image/search_icon.png",
  },
  {
    "lessonName": "Bruh",
    "images": 'assets/image/search_icon.png',
  },
  {
    "lessonName": "Shuaige",
    "images": 'assets/image/search_icon.png',
  },
  {
    "lessonName": "Meinv",
    "images": 'assets/image/search_icon.png',
  },
  {
    "lessonName": "Diaoni",
    "images": 'assets/image/search_icon.png',
  },
];