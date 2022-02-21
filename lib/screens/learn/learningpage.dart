import 'package:flutter/material.dart';
import 'package:handsfree/main.dart';
import 'package:handsfree/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

String title = "HELLO";

class learningPage extends StatefulWidget {
  const learningPage({Key? key}) : super(key: key);

  @override
  _learningPageState createState() => _learningPageState();
}

class _learningPageState extends State<learningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/white_background.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
          margin: const EdgeInsets.only(top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  letterSpacing: 2,
                  fontSize: 48.83,
                  fontWeight: FontWeight.w700,
                  color: kText,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
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
                        image: AssetImage('assets/image/learning_big_rect.png'),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    height: 340,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/dummy_hand.png'),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 13),
              ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      margin: EdgeInsets.only(top: 8),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 130,
                            height: 200,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                alignment: Alignment.topCenter,
                                image: AssetImage(
                                    'assets/image/lesson_2_thumbnail.png'),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 28)),
                              Text(
                                "afasdhfsd",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kText,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 7),
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
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: LinearPercentIndicator(
                          percent: 0.5,
                          lineHeight: 8,
                          progressColor: kOrangeDeep,
                          animation: true),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
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
      ),
    );
  }
}
