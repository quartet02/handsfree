class lessonModel {
  String lessonName;
  String lessonDesc;
  String images;

  lessonModel(this.lessonName, this.lessonDesc, this.images);
}

List<lessonModel> lessons = lessonData
    .map(
      (item) => lessonModel(
        item['lessonName'] ?? "",
        item['lessonDesc'] ?? "",
        item['images'] ?? "",
      ),
    )
    .toList();

var lessonData = [
  {
    "lessonName": "Lesson 1",
    "lessonDesc": "haha",
    "images": "assets/image/lesson_1_thumbnail.png",
  },
  {
    "lessonName": "Lesson 2",
    "lessonDesc": "haha",
    "images": 'assets/image/lesson_2_thumbnail.png',
  },
  {
    "lessonName": "Lesson 3",
    "lessonDesc": "haha",
    "images": 'assets/image/assignment_1_thumbnail.png',
  },
  {
    "lessonName": "Lesson 4",
    "lessonDesc": "haha",
    "images": 'assets/image/lesson_3_thumbnail.png',
  },
  {
    "lessonName": "Lesson 5",
    "lessonDesc": "haha",
    "images": 'assets/image/lesson_1_thumbnail.png',
  },
];
