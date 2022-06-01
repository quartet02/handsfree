import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handsfree/provider/lessonCardProvider.dart';
import 'package:handsfree/provider/subLessonProvider.dart';
import 'package:handsfree/screens/learn/subLesson.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/provider/lessonProvider.dart';
import 'package:handsfree/widgets/columnList.dart';
import 'package:handsfree/widgets/loadingWholeScreen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:handsfree/models/lessonModel.dart';
import 'package:handsfree/widgets/navBar.dart';
import 'package:provider/provider.dart';
import '../../models/newUser.dart';

double progress = 0.21;

class Learn extends StatefulWidget {
  const Learn({Key? key}) : super(key: key);
  @override
  _LearnState createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  @override
  void initState() {
    try {
      LessonRefresh.refresh();
    } catch (e) {
      debugPrint('Up to Date');
    }
    super.initState();
  }

  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUserData?>(context);
    if (user == null) return Loading();
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(milliseconds: 500);

        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          final message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 18);

          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: StreamBuilder<List<LessonModel>?>(
        stream: DatabaseService(uid: user.uid).getSyllabusOverview(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<LessonModel>? syllabusOverview = snapshot.data;
            if (syllabusOverview!.isNotEmpty) {
              Provider.of<LessonProvider>(context, listen: false)
                  .setLessons(syllabusOverview);
            }

            int total = syllabusOverview.length;
            int i = 0;
            for (LessonModel each in syllabusOverview) {
              if (each.isCompleted == true) {
                i++;
              } else {
                //do nothing
              }
            }
            progress = i / total;

            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage('assets/image/purple_heading.png'),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 30, bottom: 5, right: 30),
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 14),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Basic Text',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: kTextLight,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                ),
                                Text(
                                  (progress * 100).toString() + '% completed',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: kTextLight,
                                  ),
                                ),
                              ],
                            ),
                            progress == 0
                                ? Container()
                                : Container(
                                    alignment: Alignment.centerRight,
                                    width: 60,
                                    height: 60,
                                    child: Stack(children: <Widget>[
                                      Image.asset(
                                        'assets/image/large_progress_bar.png',
                                        scale: 4,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(7),
                                        child: CircularPercentIndicator(
                                          radius: 22.0,
                                          lineWidth: 5.0,
                                          percent: progress,
                                          // center: new Text("100%"),
                                          progressColor: kOrangeMid,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: Image.asset(
                                          'assets/image/small_progress_bar.png',
                                          scale: 4,
                                        ),
                                      ),
                                    ]),
                                  ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 60),
                      ),
                      ShaderMask(
                        shaderCallback: (Rect rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.purple,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.purple
                            ],
                            stops: [
                              0.0,
                              0.05,
                              0.95,
                              1.0
                            ], // 10% purple, 80% transparent, 10% purple
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstOut,
                        child: Consumer<LessonProvider>(
                            builder: (context, providerLesson, child) {
                          var lessons = providerLesson.lessons;

                          return Container(
                            height: MediaQuery.of(context).size.height / 1.7,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 8),
                              itemCount: lessons.length - 2,
                              itemBuilder: (context, index) {
                                return
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     Provider.of<LessonProvider>(context,
                                    //             listen: false)
                                    //         .setClickLesson(lessons[index]);
                                    //     if (index >= 2) {
                                    //       Provider.of<LessonProvider>(context,
                                    //               listen: false)
                                    //           .setPractical = true;
                                    //       debugPrint("isPractical");
                                    //     } else {
                                    //       Provider.of<LessonProvider>(context,
                                    //               listen: false)
                                    //           .setPractical = false;
                                    //       debugPrint("is not Practical");
                                    //     }
                                    //     Navigator.pushNamed(context, "/sublevel");
                                    //   },
                                    //   child: ColumnList(
                                    //     lesson: lessons[index],
                                    //   ),
                                    // );
                                    Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<LessonProvider>(context,
                                                listen: false)
                                            .setClickLesson(lessons[index]);
                                        Provider.of<LessonProvider>(context,
                                                listen: false)
                                            .setPractical = false;
                                        debugPrint("is not Practical");
                                        Provider.of<LessonCardProvider>(context,
                                            listen: false)
                                            .setCurrentTypeOfTest = -1;
                                        Navigator.pushNamed(
                                            context, "/sublevel");
                                      },
                                      child: ColumnList(
                                        lesson: lessons[index],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<LessonProvider>(context,
                                                listen: false)
                                            .setClickLesson(lessons[index + 2]);
                                        Provider.of<LessonProvider>(context,
                                                listen: false)
                                            .setPractical = true;
                                        Provider.of<LessonCardProvider>(context,
                                            listen: false)
                                            .setCurrentTypeOfTest = Random().nextInt(3);
                                        debugPrint("isPractical");
                                        Navigator.pushNamed(
                                            context, "/sublevel");
                                      },
                                      child: ColumnList(
                                        lesson: lessons[index + 2],
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: NavBar.Buttons(context),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              extendBody: true,
              bottomNavigationBar: NavBar.bar(context, 2),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
