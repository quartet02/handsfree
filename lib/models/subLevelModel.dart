class subLevelModel {
  String lessonName;
  String lessonDesc;
  String images;

  subLevelModel(this.lessonName, this.lessonDesc, this.images);
}

List<subLevelModel> sublevels = sublevelData
    .map(
      (item) => subLevelModel(
        item['lessonName'] ?? "",
        item['lessonDesc'] ?? "",
        item['images'] ?? "",
      ),
    )
    .toList();

var sublevelData = [
  {
    "lessonName": "Lesson 1",
    "lessonDesc": "haha",
    "images": "assets/image/lesson_1_thumbnail.png",
  },
  {
    "lessonName": "Lesson 2",
    "lessonDesc": "haha1231231",
    "images": 'assets/image/lesson_2_thumbnail.png',
  },
  {
    "lessonName": "Lesson 3",
    "lessonDesc": "haha43253246",
    "images": 'assets/image/assignment_1_thumbnail.png',
  },
  {
    "lessonName": "Lesson 4",
    "lessonDesc": "haha32156",
    "images": 'assets/image/lesson_3_thumbnail.png',
  },
  {
    "lessonName": "Lesson 5",
    "lessonDesc": "hahsdfgdsfga",
    "images": 'assets/image/lesson_1_thumbnail.png',
  },
];
