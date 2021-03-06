import 'package:flutter/material.dart';
import 'package:handsfree/screens/learn/subLesson.dart';
import 'package:handsfree/widgets/buildButton.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/provider/lessonProvider.dart';
import 'package:handsfree/widgets/columnList.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:handsfree/models/lessonModel.dart';
import 'package:handsfree/widgets/navBar.dart';
import 'package:provider/provider.dart';

double progress = 0.21;

class Learn extends StatefulWidget {
  const Learn({Key? key}) : super(key: key);
  @override
  _LearnState createState() => _LearnState();
}

class _LearnState extends State<Learn> {
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
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                // margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
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
                    Container(
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
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 8),
                      itemCount: lessons.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Provider.of<LessonProvider>(context, listen: false)
                                .setClickLesson(lessons[index]);
                            // Navigator.pushNamed(context, PageTransition(type: PageTransitionType.leftToRight, child: const SubLevel()));
                            Navigator.pushNamed(context, "/sublevel");
                          },
                          child: ColumnList(
                            lesson: lessons[index],
                          ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: NavBar.bar(context, 2),
    );
  }
}
