class communityModel {
  String communityTitle;
  String communityDesc;
  String images;

  communityModel(this.communityTitle, this.communityDesc, this.images);
}

List<communityModel> communities = communityData
    .map(
      (item) => communityModel(
        item['communityTitle'] ?? "",
        item['communityDesc'] ?? "",
        item['images'] ?? "",
      ),
    )
    .toList();

var communityData = [
  {
    "communityTitle": "Ming",
    "communityDesc": "Ming",
    "images": "assets/image/dummy_cat.png",
  },
  {
    "communityTitle": "Bruh",
    "communityDesc": "Bruh",
    "images": 'assets/image/dummy_cat.png',
  },
  {
    "communityTitle": "Shuaige",
    "communityDesc": "Shuaige",
    "images": 'assets/image/dummy_cat.png',
  },
  {
    "communityTitle": "Meinv",
    "communityDesc": "Meinv",
    "images": 'assets/image/dummy_cat.png',
  },
  {
    "communityTitle": "Diaoni",
    "communityDesc": "Diaoni",
    "images": 'assets/image/dummy_cat.png',
  },
];
