import 'package:flutter/material.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:provider/provider.dart';

import '../../models/lessonModel.dart';
import '../../provider/subLessonProvider.dart';
import '../../widgets/buildButton.dart';
import '../../widgets/constants.dart';

class TimerOut extends StatelessWidget {
  const TimerOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LessonModel subLesson =
        context.read<SubLessonProvider>().getClickedSubLesson;
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/image/magenta_heading.png'),
                fit: BoxFit.cover),
          ),
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildText.textBox('Times out!', 1, 35, TextOverflow.visible,
                      FontWeight.w700),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 8),
                  ),
                  buildText.heading1Text('Uh-Oh'),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                  buildText.textBox(
                      'Try again next time!',
                      0,
                      20,
                      TextOverflow.visible,
                      FontWeight.w500,
                      TextAlign.start,
                      kText),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                  Container(
                    height: 130,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(100, 29, 40, 63),
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        ),
                      ],
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image:
                            AssetImage('assets/image/learning_small_rect.png'),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.only(top: 14),
                      child: Row(
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
                              const Padding(padding: EdgeInsets.only(top: 28)),
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
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                  buildButton(
                    text: 'Return',
                    word: '/sublevel',
                    buttonColor: 'magenta',
                    buttonShadow: const Color.fromARGB(100, 29, 40, 63),
                    isReplaced: true,
                  )
                ],
              ))),
    );
  }
}
