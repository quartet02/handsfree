import 'package:flutter/material.dart';
import 'package:handsfree/models/lessonCardModel.dart';
import 'dart:math';

class LessonCardProvider with ChangeNotifier {
  int index = 0;
  static const int numTypeOfTest = 3;
  // randomly set test type, -1=>learn, 0=> text field, 1=> MCQ, 2 => Camera
  // [0, max)
  int currentTypeOfTest = Random().nextInt(numTypeOfTest);
  List<int> numOfWrong = [];
  bool currentQuesCrt = false;
  String quesInput = "";
  Function updateDB = () => {};
  Function showMessage = () => {}; // show snack bar message
  Function submissionTrigger = () => {}; // for text form onSubmitted
  List<String> mcqOptions = [];
  List<Duration> elapsedTime = [];
  List<String> lessonsId = [];
  List<int> allTypeOfTest = [];

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

  set showMessageFunction(Function f) {
    showMessage = f;
  }

  set updateDBFunction(Function f) {
    updateDB = f;
  }

  set submissionTriggerFunction(Function f) {
    submissionTrigger = f;
  }

  set setQuesInput(String input) {
    quesInput = input;
    notifyListeners();
  }

  void setClickLesson(LessonCardModel newClickedCardLesson) {
    _clickedCardLesson = newClickedCardLesson;
    notifyListeners();
  }

  void setLessonCardData(List<Map<String, dynamic>> newLessonCardData) {
    lessonCardData = newLessonCardData;
    notifyListeners();
  }

  void setCardLessons(List<LessonCardModel> lessonCard) {
    cardLessons = lessonCard;
    lessonsId.clear();
    for (int i = 0; i < lessonCard.length; i++) {
      lessonsId.add(cardLessons[i].lessonCardId.toString());
    }
    debugPrint(
        "set card lesson, first card: " + lessonCard[index].lessonCardTitle);
    debugPrint("current type of test in set card lessons: " + currentTypeOfTest.toString());
  }

  void initMcqOptions() {
    mcqOptions.clear();
    mcqOptions.add(cardLessons[index].lessonCardTitle);
    int n = 3;
    int rand;

    while (n != 0) {
      rand = Random().nextInt(cardLessons.length);
      if (rand != index &&
          !mcqOptions.contains(cardLessons[rand].lessonCardTitle)) {
        mcqOptions.add(cardLessons[rand].lessonCardTitle);
        n -= 1;
      }
    }
    debugPrint("index: " + index.toString());
    debugPrint("ans: " + cardLessons[index].lessonCardTitle);
    debugPrint("mcqOptions: " + mcqOptions.toString());
    mcqOptions.shuffle();
  }

  void initTime() {
    elapsedTime = List.filled(cardLessons.length, Duration(milliseconds: 0));
  }

  void initTest() {
    // if (index==0) return;
    numOfWrong = List.filled(cardLessons.length, 0);
    allTypeOfTest = List.filled(cardLessons.length, 0);
    allTypeOfTest[index] = currentTypeOfTest;
    if (currentTypeOfTest == 1) {
      initMcqOptions();
    }
  }

  void increment() {
    index++;
    currentQuesCrt = false;
    if (currentTypeOfTest == 1) {
      initMcqOptions();
    }
    notifyListeners();
  }

  void reset() {
    index = 0;
    currentTypeOfTest = Random().nextInt(numTypeOfTest);
    notifyListeners();
  }

  void checkAns() {
    // debugPrint(cardLessons[index]
    //     .lessonCardTitle
    //     .toString()
    //     .toUpperCase());
    // debugPrint(quesInput.toUpperCase());
    if (cardLessons[index]
            .lessonCardTitle
            .toString()
            .toUpperCase()
            .compareTo(quesInput.toUpperCase()) ==
        0) {
      currentQuesCrt = true;
    } else {
      _numOfWrongIncrement();
      currentQuesCrt = false;
    }
    showMessage(currentQuesCrt);
    quesInput = "";
    submissionTrigger();
    if (currentQuesCrt) {
      // if (index == cardLessons.length - 2)
      //   setCurrentTypeOfTest = 2;
      // else
      setCurrentTypeOfTest = Random().nextInt(numTypeOfTest);
      updateDB();
    }
  }

  void setStopwatch(Duration elapsed) {
    elapsedTime[index] = elapsed;
  }

  void _numOfWrongIncrement() {
    numOfWrong[index] += 1;
  }

  set setCurrentTypeOfTest(int type) {
    currentTypeOfTest = type;
    debugPrint("current type of test: "+currentTypeOfTest.toString());
    try {
      allTypeOfTest[index] = type;
    } catch (e) {
      return;
    }
    notifyListeners();
  }

  LessonCardModel get getCurrentLesson {
    return cardLessons[index];
  }

  LessonCardModel get getClickedCardLesson {
    return _clickedCardLesson;
  }

  bool get getCurrentQuesCrt {
    return currentQuesCrt;
  }

  List<String> get getMcqOptions {
    return mcqOptions;
  }

  int get getCurrentTypeOfTest {
    return currentTypeOfTest;
  }

  Map<String, List> get testResult {
    return {
      "lessonsId": lessonsId,
      "allTypeOfTest": allTypeOfTest,
      "numOfWrong": numOfWrong,
      "elapsedTime": elapsedTime,
    };
  }

  void shuffleQuestions() {
    cardLessons.shuffle();
  }
}

List<Map<String, dynamic>> lessonCardData = [
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
