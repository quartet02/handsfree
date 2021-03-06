import 'package:flutter/material.dart';
import 'package:handsfree/models/lessonCardModel.dart';

class LessonCardProvider with ChangeNotifier {
  int index = 0;

  List<LessonCardModel> cardLessons = lessonCardData
      .map(
        (item) => LessonCardModel(
          lessonCardId: item['lessonCardId'],
          lessonCardTitle: item['lessonCardTitle'] ?? "",
          lessonCardDesc: item['lessonCardDesc'] ?? "",
          lessonCardImage: item['lessonCardImage'] ?? "",
        ),
      )
      .toList();

  LessonCardModel _clickedCardLesson = LessonCardModel(
      lessonCardId: 000,
      lessonCardTitle: "abcdefu",
      lessonCardDesc: "wa",
      lessonCardImage: "");

  void setClickLesson(LessonCardModel newClickedCardLesson) {
    _clickedCardLesson = newClickedCardLesson;
    notifyListeners();
  }

  LessonCardModel get getClickedCardLesson {
    return _clickedCardLesson;
  }

  void increment() {
    index++;
    notifyListeners();
  }

  void resetIndex() {
    index = 0;
  }
}

var lessonCardData = [
  {
    "lessonCardId": 001,
    "lessonCardTitle": "Hello",
    "lessonCardDesc": "haha",
    "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
  },
  {
    "lessonCardId": 002,
    "lessonCardTitle": "Bello",
    "lessonCardDesc": "haha1231231",
    "lessonCardImage": 'assets/image/lesson_2_thumbnail.png',
  },
  {
    "lessonCardId": 003,
    "lessonCardTitle": "Kello",
    "lessonCardDesc": "haha43253246",
    "lessonCardImage": 'assets/image/assignment_1_thumbnail.png',
  },
  {
    "lessonCardId": 004,
    "lessonCardTitle": "Tello",
    "lessonCardDesc": "haha32156",
    "lessonCardImage": 'assets/image/lesson_3_thumbnail.png',
  },
  {
    "lessonCardId": 005,
    "lessonCardTitle": "Nello",
    "lessonCardDesc": "hahsdfgdsfga",
    "lessonCardImage": 'assets/image/lesson_1_thumbnail.png',
  },
];
