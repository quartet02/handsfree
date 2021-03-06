import 'package:flutter/material.dart';
import 'package:handsfree/models/lessonModel.dart';
import 'package:handsfree/provider/subLessonProvider.dart';
import 'package:handsfree/widgets/buildButton.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/widgets/buildConfetti.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:provider/provider.dart';

class Congratulation extends StatefulWidget {
  const Congratulation({Key? key}) : super(key: key);

  @override
  _CongratulationState createState() => _CongratulationState();
}

class _CongratulationState extends State<Congratulation> {
  @override
  Widget build(BuildContext context) {
    LessonModel subLesson =
        context.read<SubLessonProvider>().getClickedSubLesson;
    return Scaffold(
      body: AllConfettiWidget(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/image/purple_background.png'),
                fit: BoxFit.cover),
          ),
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildText.textBox('Congratulations', 1, 35, FontWeight.w700),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/image/progress_circle.png'),
                      ),
                    ),
                  ),
                  buildText.textBox(
                      'You have completed', 0, 20, FontWeight.w400),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
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
                      margin: EdgeInsets.only(top: 14),
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
                    word: '/learn',
                    buttonColor: 'white',
                    buttonShadow: Color.fromARGB(100, 29, 40, 63),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
