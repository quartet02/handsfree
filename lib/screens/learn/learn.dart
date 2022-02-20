import 'package:flutter/material.dart';
import 'package:handsfree/utils/miscellaneous.dart';
import 'package:handsfree/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import '../navbar/navBar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:handsfree/models/lessonModel.dart';

double progress = 0.21;

class Learn extends StatefulWidget {
  const Learn({Key? key}) : super(key: key);
  @override
  _LearnState createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  final searchController = TextEditingController();

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
          margin: const EdgeInsets.only(top: 60),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Container(
                // margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                      child: Stack(children: <Widget>[
                        Image.asset(
                          'assets/image/large_progress_bar.png',
                          scale: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.5),
                          child: CircularPercentIndicator(
                            radius: 45.0,
                            lineWidth: 6.0,
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
                padding: EdgeInsets.only(bottom: 20),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 50),
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(left: 16, right: 6),
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    print(
                        index.toString() + "ahhahahha" + lessons[index].images);
                    return Container(
                      height: 100,
                      width: 200,
                      child: Row(
                        children: <Widget>[
                          Container(
                              child: Image.asset(
                            lessons[index].images,
                            scale: 4,
                          )),
                          Padding(padding: EdgeInsets.only(right: 30)),
                          Column(
                            children: [
                              Text(lessons[index].lessonName),
                              Padding(padding: EdgeInsets.only(top: 5)),
                              Text(lessons[index].lessonDesc),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: navBar.Buttons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: navBar.bar(),
    );
  }
}
