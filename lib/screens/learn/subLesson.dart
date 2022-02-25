import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handsfree/widgets/buildButton.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/lessonProvider.dart';
import '../../widgets/navBar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:handsfree/models/subLevelModel.dart';
import 'package:handsfree/models/lessonModel.dart';

class SubLevel extends StatelessWidget {
  const SubLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LessonModel lesson = context.read<LessonProvider>().getClickedLesson;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/image/purple_heading.png'),
            fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
        margin: const EdgeInsets.only(top: 50),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        // blurStyle: BlurStyle(9),
                        color: kShadow,
                        offset: Offset(6, 6),
                        blurRadius: 6,
                      ),
                    ],
                    image: const DecorationImage(
                        alignment: Alignment.topCenter,
                        image:
                            AssetImage('assets/image/sublevel_container.png'),
                        scale: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              alignment: Alignment.topCenter,
                              image: AssetImage(lesson.lessonImage),
                              fit: BoxFit.cover,
                              scale: 0.5,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Text(
                              lesson.lessonName,
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kText,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 5),
                            ),
                            Text(
                              lesson.lessonDesc,
                              style: GoogleFonts.montserrat(
                                fontSize: 12.8,
                                fontWeight: FontWeight.w400,
                                color: kText,
                              ),
                            ),
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
            Container(
              height: 350,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 60),
                itemCount: sublevels.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      //check index and go the the respective place
                    },
                    child: Container(
                      height: 100,
                      width: 200,
                      child: Row(
                        children: <Widget>[
                          Container(
                              child: Image.asset(
                            sublevels[index].images,
                            scale: 4,
                          )),
                          const Padding(padding: EdgeInsets.only(right: 10)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              Text(
                                sublevels[index].lessonName,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kText,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 5)),
                              Text(
                                sublevels[index].lessonDesc,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.8,
                                  fontWeight: FontWeight.w400,
                                  color: kText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                  onTap: () async {},
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
      ),
    ));
  }
}
