import 'dart:async';
import 'package:flutter/material.dart';
import 'package:handsfree/models/lessonCardModel.dart';
import 'package:handsfree/models/lessonModel.dart';
import 'package:handsfree/provider/lessonCardProvider.dart';
import 'package:handsfree/provider/lessonProvider.dart';
import 'package:handsfree/provider/subLessonProvider.dart';
import 'package:handsfree/screens/learn/textForm.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../models/newUser.dart';
import '../../services/medialoader.dart';
import '../../widgets/loadingWholeScreen.dart';
import 'package:themed/themed.dart';

import 'choices.dart';

class MainLearningPage extends StatefulWidget {
  const MainLearningPage({Key? key}) : super(key: key);

  @override
  _MainLearningPageState createState() => _MainLearningPageState();
}

class _MainLearningPageState extends State<MainLearningPage>
    with SingleTickerProviderStateMixin {
  final Stopwatch stopwatch = Stopwatch();
  late Timer oneSecTimer;
  final int countDownTime = 10;
  final ValueNotifier<int> _remainingTime = ValueNotifier<int>(10);
  bool firstTime = true;
  late final Future<List<LessonCardModel>>? lessonListFromDB;
  late final user;
  late final provider;
  late final LessonModel subLesson;
  late String syllabus;
  late String lesson;
  late final bool isPractical;

  @override
  void dispose() {
    stopwatch.stop();
    oneSecTimer.cancel();
    super.dispose();
  }

  @override
  void deactivate() {
    stopwatch.stop();
    oneSecTimer.cancel();
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();
    isPractical = context.read<LessonProvider>().getPractical;
    // 10 sec timer for practical
    oneSecTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingTime.value = _remainingTime.value - 1;

      if (_remainingTime.value <= 0) {
        // Unable to answer in time
        timer.cancel();
        // Put database func here
        debugPrint(Provider.of<LessonCardProvider?>(context, listen: false)
            ?.testResult
            .toString());
        Navigator.pushNamed(context, "/timerOut");
      }
    });
    // cancel timer if isn't practical
    if (!isPractical) oneSecTimer.cancel();

    subLesson = context.read<SubLessonProvider>().getClickedSubLesson;
    syllabus = context.read<SubLessonProvider>().getSyllabus;
    lesson = 'Unknown';

    switch (subLesson.lessonId) {
      case 1:
        lesson = "Lesson 1";
        break;
      case 2:
        lesson = "Lesson 2";
        break;
      case 3:
        lesson = "Lesson 3";
        break;
      case 4:
        lesson = "Lesson 4";
        break;
      case 5:
        lesson = "Lesson 5";
        break;
      case 6:
        lesson = "Lesson 6";
        break;
      default:
        lesson = "Lesson " + subLesson.lessonId.toString();
        break;
    }
    user = context.read<NewUserData?>();
    provider = context.read<LessonCardProvider?>();
    // set here before using in future builder to prevent calling multiple times when textField is changed
    lessonListFromDB = getLessonListFromDB(user, syllabus, lesson);
  }

  @override
  Widget build(BuildContext context) {
    if (user == null || provider == null) return Loading();
    int typeOfTest =
        Provider.of<LessonCardProvider?>(context)!.getCurrentTypeOfTest;

    return FutureBuilder<List<LessonCardModel>>(
        future: lessonListFromDB,
        builder: (BuildContext context,
            AsyncSnapshot<List<LessonCardModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Loading();
            case ConnectionState.done:
              List<LessonCardModel>? lessonCard = snapshot.data;

              if (lessonCard!.isNotEmpty && firstTime) {
                provider.initTime();
                if (isPractical) {
                  lessonCard.shuffle();
                  provider.setCardLessons(lessonCard);
                  provider.initTest();
                } else {
                  provider.setCardLessons(lessonCard);
                }
                firstTime = false;
              }

              stopwatch.reset();
              stopwatch.start();

              return Scaffold(
                body: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/image/white_background.png'),
                        fit: BoxFit.cover),
                  ),
                  child: SingleChildScrollView(
                    child: Consumer<LessonCardProvider?>(
                        builder: (context, providerCardLesson, child) {
                      var cardLesson = providerCardLesson!.cardLessons;
                      double progress =
                          (providerCardLesson.index) / cardLesson.length;

                      void updateDB() {
                        _remainingTime.value = countDownTime;
                        stopwatch.stop();
                        provider.setStopwatch(stopwatch.elapsed);

                        if (providerCardLesson.index == cardLesson.length - 1) {
                          oneSecTimer.cancel();
                          DatabaseService(uid: user.uid)
                              .updateIsCompletedSubLesson(
                                  syllabus,
                                  lesson,
                                  cardLesson[providerCardLesson.index]
                                      .lessonId);
                          DatabaseService(uid: user.uid).updateExperience();
                          DatabaseService(uid: user.uid)
                              .updateIsCompletedLesson(syllabus, lesson);
                          // put database func here
                          debugPrint(provider.testResult.toString());
                          Navigator.pushNamed(context, "/congratulation");
                        } else {
                          DatabaseService(uid: user.uid)
                              .updateIsCompletedSubLesson(
                                  syllabus,
                                  lesson,
                                  cardLesson[providerCardLesson.index]
                                      .lessonId);
                          DatabaseService(uid: user.uid).updateExperience();
                          providerCardLesson.increment();
                        }
                      }

                      provider.updateDBFunction = updateDB;
                      provider.showMessageFunction = showMessage;
                      debugPrint("Current alphabet: " +
                          provider.getCurrentLesson.lessonCardTitle);
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                            left: 40, bottom: 5, right: 40),
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            isPractical
                                ? ValueListenableBuilder(
                                    valueListenable: _remainingTime,
                                    builder: (context, value, child) {
                                      return Text(
                                        "Timer: " + value.toString(),
                                        style: GoogleFonts.montserrat(
                                          letterSpacing: 0,
                                          fontSize: 16,
                                          fontWeight: (value == 3 ||
                                                  value == 2 ||
                                                  value == 1)
                                              ? FontWeight.w700
                                              : FontWeight.w400,
                                          color: (value == 3 ||
                                                  value == 2 ||
                                                  value == 1)
                                              ? Colors.red
                                              : kText,
                                        ),
                                      );
                                    })
                                : Container(),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                            ),
                            Container(
                              height: 130,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: kTextShadow,
                                    offset: Offset(10, 10),
                                    blurRadius: 20,
                                  ),
                                ],
                                image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image: AssetImage(
                                      'assets/image/learning_small_rect.png'),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 130,
                                          height: 200,
                                          alignment: Alignment.center,
                                          child: FutureBuilder(
                                              future: getImage(
                                                  subLesson.lessonImage),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.2,
                                                    child:
                                                        snapshot.data as Widget,
                                                  );
                                                }
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.2,
                                                    child:
                                                        const CircularProgressIndicator(),
                                                  );
                                                } else {
                                                  debugPrint(
                                                      'Connection Failed');
                                                  return Container();
                                                }
                                              }),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 28)),
                                            buildText.learningHeading2Text(
                                                subLesson.lessonName),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 7),
                                            ),
                                            buildText.learningHeading3Text(
                                                subLesson.lessonDesc),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    margin: const EdgeInsets.only(bottom: 15),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: LinearPercentIndicator(
                                      barRadius: Radius.circular(20),
                                      percent: progress,
                                      lineHeight: 8,
                                      progressColor: kOrangeDeep,
                                      animation: true,
                                      animateFromLastPercent: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                            ),
                            isPractical
                                ? Container()
                                : buildText.learningText(
                                    provider.getCurrentLesson.lessonCardTitle),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 5),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  // change image container height if it's mcq
                                  height:
                                      MediaQuery.of(context).size.height / 2.4,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: kTextShadow,
                                        offset: Offset(10, 10),
                                        blurRadius: 20,
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/image/learning_big_rect.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 2.45,
                                  child: FutureBuilder(
                                      future: FireStorageService.loadImage(
                                          provider.getCurrentLesson
                                              .lessonCardImage),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            child: ChangeColors(
                                                brightness: 0.1,
                                                saturation: 0.2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: Image.network(
                                                                  snapshot.data
                                                                      as String)
                                                              .image,
                                                          scale: 16)),
                                                )),
                                          );
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            child:
                                                const CircularProgressIndicator(),
                                          );
                                        } else {
                                          debugPrint('Connection Failed');
                                          return Container();
                                        }
                                      }),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 20),
                            ),
                            isPractical
                                ? Container()
                                : buildText.heading2Text(
                                    provider.getCurrentLesson.lessonCardDesc),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 13),
                            ),
                            if (isPractical)
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 0.8,
                                  // height: MediaQuery.of(context).size.height / 12,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/image/text_field.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: kTextShadow,
                                          offset: Offset(6, 6),
                                          blurRadius: 6,
                                        ),
                                      ]),
                                  child:
                                      // if is text field
                                      typeOfTestWidget(typeOfTest)),
                            isPractical && typeOfTest == 1
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: GestureDetector(
                                        onTap: () {
                                          if (isPractical) {
                                            provider.checkAns();
                                          } else {
                                            provider.updateDB();
                                          }
                                        },
                                        child: Stack(children: <Widget>[
                                          Center(
                                            child: Container(
                                                alignment: Alignment.center,
                                                width: 200,
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: kButtonShadow,
                                                        offset: Offset(6, 6),
                                                        blurRadius: 6,
                                                      ),
                                                    ]),
                                                child: Image.asset(
                                                  'assets/image/purple_button.png',
                                                  scale: 4,
                                                )),
                                          ),
                                          Container(
                                            height: 40,
                                            alignment: Alignment.center,
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              'Next',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: kTextLight,
                                              ),
                                            ),
                                          ),
                                        ])),
                                  ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              );

            default:
              return Loading();
          }
        });
  }

  void showMessage(bool isCrt) {
    String msg = isCrt ? "Correct Answer" : "Incorrect Answer";
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: kPurpleLight,
    ));
  }

  Widget typeOfTestWidget(type) {
    if (type == 0) {
      return const TextForm();
    } else if (type == 1) {
      return const Choices();
    } else {
      return Container();
    }
  }
}

Future<List<LessonCardModel>> getLessonListFromDB(user, syllabus, lesson) {
  return DatabaseService(uid: user.uid)
      .getSelectedLessonCardList(syllabus, lesson);
}
