import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/widgets/buildText.dart';

import '../../widgets/constants.dart';

class LevelForm extends StatelessWidget {
  const LevelForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/sign_up.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 35, bottom: 5, right: 35),
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),
          child: Column(children: <Widget>[
            buildText.heading2Text("Did you learnt handsign before?"),

            //first Button
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 40),
              child: GestureDetector(
                  onTap: () async {
                    Navigator.pushNamed(context, "/auth");
                  },
                  child: buttonDeco("Begineer")),
            ),
            //Second Button
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 40),
              child: GestureDetector(
                  onTap: () async {
                    //Func here
                  },
                  child: buttonDeco("Intermediate")),
            ),
            //Third Button
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 40),
              child: GestureDetector(
                  onTap: () async {
                    //Func here
                  },
                  child: buttonDeco("Expert")),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buttonDeco(String buttonText) {
    return Stack(children: <Widget>[
      Center(
        child: Container(
            alignment: Alignment.center,
            width: 200,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: kButtonShadow,
                    offset: Offset(6, 6),
                    blurRadius: 6,
                  ),
                ]),
            child: Image.asset(
              'assets/image/magenta_button.png',
              scale: 1,
            )),
      ),
      Container(
        height: 40,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          buttonText,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kTextLight,
          ),
        ),
      ),
    ]);
  }
}
