import 'package:flutter/material.dart';
import 'package:handsfree/services/auth.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class buildButton extends StatelessWidget {
  final String text;
  final String word;
  final bool isReplaced;
  String buttonColor;
  Color buttonShadow;
  late final bool isSignOut;
  final BuildContext context;

  buildButton(
      {required this.context,
      required this.text,
      required this.word,
      required this.buttonColor,
      this.buttonShadow = kButtonShadow,
      this.isSignOut = false,
      this.isReplaced = false});

  void navigate(BuildContext context, String word, bool isReplaced) {
    if (isSignOut) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              backgroundColor: kBackgroundColour,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 100,
              title: buildText.heading2Text("Please don't go.."),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    buildText.heading3Text("Are you sure you want to log out?"),
                  ],
                ),
              ),
              actions: [
                //===========================Yes=========================
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/auth", (route) => false);
                    final AuthService _auth = AuthService();
                    _auth.signOut();
                  },
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 200,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Sign out",
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
                //===============================No===========================
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
            );
          });
    } else {
      isReplaced
          ? Navigator.pushNamedAndRemoveUntil(
              context, word, ModalRoute.withName("/sublevel"))
          : Navigator.pushNamed(context, word);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = kText;
    if (buttonColor.contains('purple')) {
      buttonColor = 'assets/image/purple_button.png';
      textColor = kTextLight;
    } else if (buttonColor.contains('white')) {
      buttonColor = 'assets/image/white_button.png';
      textColor = kText;
    } else if (buttonColor.contains('magenta')) {
      buttonColor = 'assets/image/magenta_button.png';
      textColor = kTextLight;
    }

    return GestureDetector(
      onTap: () => navigate(context, word, isReplaced),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
                alignment: Alignment.center,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: buttonShadow,
                        offset: Offset(6, 6),
                        blurRadius: 6,
                      ),
                    ]),
                child: Image.asset(
                  buttonColor,
                  scale: 4,
                )),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
