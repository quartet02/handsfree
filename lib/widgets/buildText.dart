import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

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

  static Widget textBox(
    String text,
    double spacing,
    double size,
    FontWeight weight,
    TextAlign textAlignment, [
    Color colour = kTextLight,
  ]) {
    return Text(text,
        style: GoogleFonts.montserrat(
          letterSpacing: spacing,
          fontSize: size,
          fontWeight: weight,
          color: colour,
        ),
        textAlign: textAlignment);
  }

  static Widget bigTitle(String text,
      [Color colour = kTextLight, TextAlign textAlignment = TextAlign.start]) {
    return textBox(text, 2, 25, FontWeight.w800, textAlignment, colour);
  }

  static Widget heading1Text(String text,
      [TextAlign textAlignment = TextAlign.start]) {
    return textBox(text, 2, 25, FontWeight.w800, textAlignment, kText);
  }

  static Widget heading2Text(String text,
      [TextAlign textAlignment = TextAlign.start]) {
    return textBox(text, 0, 20, FontWeight.w600, textAlignment, kText);
  }

  static Widget heading3Text(String text,
      [TextAlign textAlignment = TextAlign.start]) {
    return textBox(text, 0, 16, FontWeight.w500, textAlignment, kText);
  }

  static Widget heading4Text(String text,
      [TextAlign textAlignment = TextAlign.start]) {
    return textBox(text, 0, 10.24, FontWeight.w400, textAlignment, kText);
  }

  static Widget heading5Text(String text,
      [TextAlign textAlignment = TextAlign.start]) {
    return textBox(text, 0, 10.24, FontWeight.w300, textAlignment, kText);
  }
}
