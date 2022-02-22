import 'package:flutter/material.dart';
import 'package:handsfree/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class buildButton extends StatelessWidget {
  final String text;
  final String word;
  String buttonColor;
  Color buttonShadow;

  buildButton(
      {required this.text,
      required this.word,
      required this.buttonColor,
      this.buttonShadow = kButtonShadow});

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
        onTap: () {
          Navigator.pushReplacementNamed(context, word);
        },
        child: Stack(children: <Widget>[
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
        ]));
  }
}

class buildTextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget textBox(TextEditingController controllers, String hint,
      bool blockText, bool autoCorrect, String errorMessage,
      {EdgeInsets margins = const EdgeInsets.all(0)}) {
    double radius = 25;
    return Container(
      margin: margins,
      decoration: BoxDecoration(
          color: Colors.transparent,
          image: const DecorationImage(
            image: AssetImage('assets/image/text_field.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: const [
            BoxShadow(
              color: kTextShadow,
              offset: Offset(6, 6),
              blurRadius: 6,
            ),
          ]),
      child: TextFormField(
        controller: controllers,
        obscureText: blockText,
        autocorrect: autoCorrect,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: hint,
          labelStyle: GoogleFonts.montserrat(
            fontSize: 12.8,
            fontWeight: FontWeight.w400,
            color: kTextFieldText,
          ),
          hintStyle: GoogleFonts.montserrat(
            fontSize: 12.8,
            fontWeight: FontWeight.w400,
            color: kTextFieldText,
          ),
          fillColor: kTextLight,
          filled: false,
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }

  static Widget passBox(TextEditingController controllers, String hint,
      bool blockText, bool autoCorrect, String errorMessage, bool confirm) {
    double radius = 25;
    return Container(
      decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/image/text_field.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: const [
            BoxShadow(
              color: kTextShadow,
              offset: Offset(6, 6),
              blurRadius: 6,
            ),
          ]),
      child: TextFormField(
        controller: controllers,
        obscureText: blockText,
        autocorrect: autoCorrect,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: hint,
          labelStyle: GoogleFonts.montserrat(
            fontSize: 12.8,
            fontWeight: FontWeight.w400,
            color: kTextFieldText,
          ),
          hintStyle: GoogleFonts.montserrat(
            fontSize: 12.8,
            fontWeight: FontWeight.w400,
            color: kTextFieldText,
          ),
          fillColor: kTextLight,
          filled: false,
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please retype your password';
          } else if (controllers.text != controllers.text) {
            return 'Password not same';
          }
          return null;
        },
      ),
    );
  }
}

class buildText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget labelText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: kText,
        ),
      ),
    );
  }

  static Widget headingText(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        letterSpacing: 2,
        fontSize: 25,
        fontWeight: FontWeight.w800,
        color: kTextLight,
      ),
    );
  }

  static Widget heading2Text(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        letterSpacing: 0,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: kText,
      ),
    );
  }

  static Widget heading3Text(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        letterSpacing: 0,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: kText,
      ),
    );
  }

  static Widget heading4Text(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        letterSpacing: 0,
        fontSize: 10.24,
        fontWeight: FontWeight.w400,
        color: kText,
      ),
    );
  }

  static Widget heading5Text(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        letterSpacing: 0,
        fontSize: 10.24,
        fontWeight: FontWeight.w300,
        color: kText,
      ),
    );
  }

  static Widget text(
      String text, double spacing, double size, FontWeight weight) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        letterSpacing: spacing,
        fontSize: size,
        fontWeight: weight,
        color: kTextLight,
      ),
    );
  }
}
