import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/screens/learn/sublevel.dart';
import 'package:handsfree/utils/provider/lessonProvider.dart';
import 'package:provider/provider.dart';

import '../models/lessonModel.dart';
import '../utils/constants.dart';

class ColumnList extends StatelessWidget {
  final LessonModel lesson;

  ColumnList({required this.lesson});

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {
          context.read<LessonProvider>().setClickLesson = lesson;
          Navigator.pushNamed(context, "/sublevel");
        },
        child: Container(
          height: 100,
          width: 200,
          child: Row(
            children: <Widget>[
              Container(
                  child: Image.asset(
                lesson.lessonImage,
                scale: 4,
              )),
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
        ),
      );
  }
}
