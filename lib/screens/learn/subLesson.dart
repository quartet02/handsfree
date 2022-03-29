import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:handsfree/provider/lessonCardProvider.dart';
import 'package:handsfree/provider/subLessonProvider.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/loadingWholeScreen.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/columnList.dart';
import 'package:provider/provider.dart';
import '../../models/newUser.dart';
import '../../provider/lessonProvider.dart';
import '../../services/medialoader.dart';
import 'package:handsfree/models/lessonModel.dart';

List _lessonCompletionList = [];
List<LessonModel>? _userModel;
String _syllabus = 'Unknown';
dynamic _user;

class SubLevel extends StatelessWidget {
  const SubLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LessonModel lesson = context.read<LessonProvider>().getClickedLesson;
    _user = Provider.of<NewUserData?>(context);
    _syllabus = "Syllabus " + lesson.lessonId.toString();

    if (_user == null) return Loading();

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popAndPushNamed('/learn', result: true);
        return true;
      },
      child: StreamBuilder<List<LessonModel>?>(
          stream: DatabaseService(uid: _user!.uid).getSyllabus(_syllabus),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _userModel = snapshot.data;
              if (_userModel!.isNotEmpty) {
                Provider.of<SubLessonProvider>(context, listen: false)
                    .setSubLessons(_userModel);
              }

              bool completionOfSyllabus = true;
              for (int i = 0; i < _userModel!.length; i++) {
                completionOfSyllabus =
                    completionOfSyllabus && _userModel![i].isCompleted;
              }
              if (completionOfSyllabus) {
                DatabaseService(uid: _user.uid)
                    .updateIsCompletedSyllabus(_syllabus);
              }

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
                      top: MediaQuery.of(context).size.height / 20),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image: AssetImage(
                                      'assets/image/sublevel_container.png'),
                                  scale: 2),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 53),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    width: 100,
                                    height: 200,
                                    alignment: Alignment.center,
                                    child: FutureBuilder(
                                        future: getImage(lesson.lessonImage),
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
                                              child: snapshot.data as Widget,
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
                                                  CircularProgressIndicator(),
                                            );
                                          } else {
                                            print('Connection Failed');
                                            return Container();
                                          }
                                        }),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(top: 20)),
                                      buildText.learningHeading2Text(
                                          lesson.lessonName),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                      ),
                                      buildText.learningHeading3Text(
                                          lesson.lessonDesc),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 80),
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
                        child: Consumer<SubLessonProvider>(
                            builder: (context, providerSubLesson, child) {
                          var subLessons = providerSubLesson.subLessons;
                          return Container(
                            height: MediaQuery.of(context).size.height / 1.6,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width / 8,
                                  left: MediaQuery.of(context).size.width / 12),
                              itemCount: subLessons.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Provider.of<LessonCardProvider>(context,
                                            listen: false)
                                        .resetIndex();
                                    Provider.of<SubLessonProvider>(context,
                                            listen: false)
                                        .setClickLesson(subLessons[index]);
                                    Provider.of<SubLessonProvider>(context,
                                            listen: false)
                                        .setSyllabus(_syllabus);
                                    Navigator.pushReplacementNamed(
                                        context, "/mainLearningPage");
                                  },
                                  child: ColumnList(lesson: subLessons[index]),
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ));
            } else {
              return Loading();
            }
          }),
    );
  }
}

class LessonRefresh {
  static void refresh() {
    bool completionOfSyllabus = true;
    for (int i = 0; i < _userModel!.length; i++) {
      completionOfSyllabus = completionOfSyllabus && _userModel![i].isCompleted;
    }
    if (completionOfSyllabus) {
      DatabaseService(uid: _user.uid).updateIsCompletedSyllabus(_syllabus);
    }
  }
}
