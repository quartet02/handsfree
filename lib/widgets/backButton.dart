import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/provider/lessonCardProvider.dart';
import 'package:provider/provider.dart';
import 'package:handsfree/widgets/buildText.dart';

import 'constants.dart';

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget backButton(BuildContext context, double left, double height) {
    return Positioned(
      left: left,
      top: MediaQuery.of(context).size.height / height,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context, true);
          Clipboard.setData(const ClipboardData());
          HapticFeedback.mediumImpact();
          Feedback.forTap(context);
        },
        child: Container(
          padding: EdgeInsets.all(5),
          height: 30,
          width: 30,
          child: Container(
            height: 20,
            width: 15,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  // alignment: Alignment.topLeft,
                  image: AssetImage('assets/image/back_button.png'),
                  fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }

  static Widget blackBackButton(
      BuildContext context, double left, double height) {
    return Positioned(
      left: left,
      top: MediaQuery.of(context).size.height / height,
      child: GestureDetector(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    actionsAlignment: MainAxisAlignment.center,
                    backgroundColor: kBackgroundColour,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 100,
                    title: buildText.heading2Text("Stop learning.."),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          buildText.heading3Text(
                              "Are you sure you want to stop learning?"),
                        ],
                      ),
                    ),
                    actions: [
                      //=====================================Yes=========================
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Clipboard.setData(const ClipboardData());
                          HapticFeedback.heavyImpact();
                          Feedback.forTap(context);
                        },
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: 200,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "Exit",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kPurpleDeep,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      //=================================No==========================
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  width: 200,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: kPurpleDeep,
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
                                "No",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kTextLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20)),
                    ],
                  ));
        },
        child: Container(
          padding: EdgeInsets.all(5),
          height: 30,
          width: 30,
          child: Container(
            height: 20,
            width: 15,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  // alignment: Alignment.topLeft,
                  image: AssetImage('assets/image/black_back_button.png'),
                  fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }

  static Widget playgroundButton(BuildContext context) {
    return Positioned(
      right: 50,
      top: MediaQuery.of(context).size.height / 2.9,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/handsignPlayground");
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            image: DecorationImage(
                // alignment: Alignment.topLeft,
                image: AssetImage('assets/image/party_horn.png'),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  static Widget reportButton(BuildContext context, String title, Function func) {
    return Positioned(
      right: 50,
      top: MediaQuery.of(context).size.height / 2.5,
      child: GestureDetector(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    actionsAlignment: MainAxisAlignment.center,
                    backgroundColor: kBackgroundColour,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 100,
                    title: buildText.heading2Text("Report"),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          buildText
                              .heading3Text("Do you want to report this page?"),
                        ],
                      ),
                    ),
                    actions: [
                      //========================Yes======================
                      GestureDetector(
                        onTap: () {
                          Provider.of<LessonCardProvider>(context,
                                  listen: false)
                              .setQuesInput = title;
                          Navigator.of(context).pop();
                          func();
                        },
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: 200,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "Report",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kMagentaDeep,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      //===============================No======================
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  width: 200,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: kMagentaDeep,
                                          offset: Offset(6, 6),
                                          blurRadius: 6,
                                        ),
                                      ]),
                                  child: Image.asset(
                                    'assets/image/magenta_button.png',
                                    scale: 4,
                                  )),
                            ),
                            Container(
                              height: 40,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "No",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kTextLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20)),
                    ],
                  ));
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            image: DecorationImage(
                // alignment: Alignment.topLeft,
                image: AssetImage('assets/image/report_button_new.png'),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
