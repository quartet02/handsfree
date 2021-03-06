import 'package:flutter/material.dart';
import 'package:handsfree/main.dart';
import 'package:handsfree/models/lessonCardModel.dart';
import 'package:handsfree/models/lessonModel.dart';
import 'package:handsfree/provider/lessonCardProvider.dart';
import 'package:handsfree/provider/subLessonProvider.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class MainLearningPage extends StatefulWidget {
  const MainLearningPage({Key? key}) : super(key: key);

  @override
  _MainLearningPageState createState() => _MainLearningPageState();
}

class _MainLearningPageState extends State<MainLearningPage> {
  @override
  Widget build(BuildContext context) {
    LessonModel subLesson =
        context.read<SubLessonProvider>().getClickedSubLesson;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/white_background.png'),
              fit: BoxFit.cover),
        ),
        child: Consumer<LessonCardProvider>(
            builder: (context, providerCardLesson, child) {
          var cardLesson = providerCardLesson.cardLessons;
          double progress = (providerCardLesson.index) / cardLesson.length;
          double lastProgress =
              (providerCardLesson.index - 1) / cardLesson.length;
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 130,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: kTextShadow,
                        offset: Offset(10, 10),
                        blurRadius: 20,
                      ),
                    ],
                    image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage('assets/image/learning_small_rect.png'),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.only(top: 8),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 130,
                              height: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image: AssetImage(subLesson.lessonImage),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(top: 28)),
                                buildText
                                    .learningHeading2Text(subLesson.lessonName),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 7),
                                ),
                                buildText
                                    .learningHeading3Text(subLesson.lessonDesc),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 15),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: LinearPercentIndicator(
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
                buildText.learningText(
                    cardLesson[providerCardLesson.index].lessonCardTitle),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                ),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.4,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: kTextShadow,
                            offset: Offset(10, 10),
                            blurRadius: 20,
                          ),
                        ],
                        image: DecorationImage(
                          image:
                              AssetImage('assets/image/learning_big_rect.png'),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.45,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(cardLesson[providerCardLesson.index]
                              .lessonCardImage),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                buildText.heading2Text(
                    cardLesson[providerCardLesson.index].lessonCardDesc),
                const Padding(
                  padding: EdgeInsets.only(bottom: 13),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                      onTap: () {
                        if (providerCardLesson.index == cardLesson.length - 1) {
                          Navigator.pushNamed(context, "/congratulation");
                        } else {
                          providerCardLesson.increment();
                        }
                      },
                      child: Stack(children: <Widget>[
                        Center(
                          child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
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
                          padding: const EdgeInsets.only(top: 10),
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
    );
  }
}
