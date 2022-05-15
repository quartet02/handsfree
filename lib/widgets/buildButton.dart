import 'package:flutter/material.dart';
import 'package:handsfree/services/auth.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class buildButton extends StatelessWidget {
  final String text;
  final String word;
  final bool isReplaced;
  String buttonColor;
  Color buttonShadow;
  late final bool isSignOut;

  buildButton(
      {required this.text,
      required this.word,
      required this.buttonColor,
      this.buttonShadow = kButtonShadow,
      this.isSignOut = false,
      this.isReplaced = false});

  void navigate(BuildContext context, String word, bool isReplaced) {
    if (isSignOut) {
      final AuthService _auth = AuthService();
      _auth.signOut();
      Navigator.pushNamed(context, "/auth");
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
