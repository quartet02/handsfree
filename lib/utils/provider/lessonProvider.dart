import 'package:flutter/cupertino.dart';
import 'package:handsfree/models/lessonModel.dart';

class LessonProvider with ChangeNotifier {
  List<LessonModel> lessons = lessonData
      .map(
        (item) => LessonModel(
          lessonId: item['lessonId'],
          lessonName: item['lessonName'] ?? "",
          lessonDesc: item['lessonDesc'] ?? "",
          lessonImage: item['lessonImage'] ?? "",
        ),
      )
      .toList();

  List<LessonModel> get lessonDetails {
    return [...lessons];
  }

  LessonModel clickedLesson = LessonModel(
      lessonId: 000, lessonName: "HAHA", lessonDesc: "haha", lessonImage: "");

  LessonModel get getClickedLesson {
    return clickedLesson;
  }

  set setClickLesson(LessonModel newClickedLesson) {
    clickedLesson = newClickedLesson;
    print(clickedLesson.lessonName);
    notifyListeners();
  }
}

var lessonData = [
  {
    "lessonId": 001,
    "lessonName": "Lesson 1",
    "lessonDesc": "haha",
    "lessonImage": "assets/image/lesson_1_thumbnail.png",
  },
  {
    "lessonId": 002,
    "lessonName": "Lesson 2",
    "lessonDesc": "haha1231231",
    "lessonImage": 'assets/image/lesson_2_thumbnail.png',
  },
  {
    "lessonId": 003,
    "lessonName": "Lesson 3",
    "lessonDesc": "haha43253246",
    "lessonImage": 'assets/image/assignment_1_thumbnail.png',
  },
  {
    "lessonId": 004,
    "lessonName": "Lesson 4",
    "lessonDesc": "haha32156",
    "lessonImage": 'assets/image/lesson_3_thumbnail.png',
  },
  {
    "lessonId": 005,
    "lessonName": "Lesson 5",
    "lessonDesc": "hahsdfgdsfga",
    "lessonImage": 'assets/image/lesson_1_thumbnail.png',
  },
];
