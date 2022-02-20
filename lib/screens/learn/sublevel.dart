import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:handsfree/utils/miscellaneous.dart';
import 'package:handsfree/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import '../navbar/navBar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:handsfree/models/subLevelModel.dart';

class subLevel extends StatefulWidget {
  const subLevel({Key? key}) : super(key: key);
  @override
  _LearnState createState() => _LearnState();
}

class _LearnState extends State<subLevel> {
  @override
  Widget build(BuildContext context) {
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
          physics: const ClampingScrollPhysics(),
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/image/white.png'),
                        scale: 1),
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
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              alignment: Alignment.topCenter,
                              image: AssetImage(
                                  'assets/image/lesson_2_thumbnail.png'),
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
                              "afasdhfsd",
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
                              "afasdhfsd",
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
              height: 300,
              child: ListView.builder(
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
