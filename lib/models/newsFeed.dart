class newsFeedModel {
  String newsFeedTitle;
  String newsFeedDesc;
  String newsFeedImages;

  newsFeedModel(this.newsFeedTitle, this.newsFeedDesc, this.newsFeedImages);
}

List<newsFeedModel> newsFeeds = newsFeedData
    .map(
      (item) => newsFeedModel(
        item['newsFeedTitle'] ?? "",
        item['newsFeedDesc'] ?? "",
        item['newsFeedImages'] ?? "",
      ),
    )
    .toList();

var newsFeedData = [
  {
    "newsFeedTitle": "Ming",
    "newsFeedDesc": "Ming",
    "newsFeedImages": "assets/image/dummy_cat.png",
  },
  {
    "newsFeedTitle": "Bruh",
    "newsFeedDesc": "Bruh",
    "newsFeedImages": 'assets/image/dummy_cat.png',
  },
  {
    "newsFeedTitle": "Shuaige",
    "newsFeedDesc": "Shuaige",
    "newsFeedImages": 'assets/image/dummy_cat.png',
  },
  {
    "newsFeedTitle": "Meinv",
    "newsFeedDesc": "Meinv",
    "newsFeedImages": 'assets/image/dummy_cat.png',
  },
  {
    "newsFeedTitle": "Diaoni",
    "newsFeedDesc": "Diaoni",
    "newsFeedImages": 'assets/image/dummy_cat.png',
  },
];
