import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/provider/subLessonProvider.dart';
import 'package:handsfree/screens/learn/subLesson.dart';
import 'package:handsfree/provider/lessonProvider.dart';
import 'package:handsfree/services/medialoader.dart';
import 'package:provider/provider.dart';

import '../models/lessonModel.dart';
import 'constants.dart';

class ColumnList extends StatelessWidget {
  LessonModel lesson;

  ColumnList({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(bottom: 15),
              child: Visibility(
                visible: true,
                child: Image.asset(
                  lesson.isCompleted
                      ? "assets/image/tick.png"
                      : "assets/image/invi.png",
                  scale: 4,
                ),
              )),
          FutureBuilder(
              future: FireStorageService.loadImage(lesson.lessonImage),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          scale: 4,
                          image: Image.network(snapshot.data as String).image),
                    ),
                  );
                } else {
                  return const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          const Padding(padding: EdgeInsets.only(right: 10)),
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
              const Padding(padding: EdgeInsets.only(top: 5)),
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
    );
  }
}
