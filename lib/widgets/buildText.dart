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
    TextOverflow tovf,
    FontWeight weight, [
    TextAlign textAlignment = TextAlign.start,
    Color colour = kTextLight,
  ]) {
    return Text(text,
        style: GoogleFonts.montserrat(
          letterSpacing: spacing,
          fontSize: size,
          fontWeight: weight,
          color: colour,
        ),
        overflow: tovf,
        // softWrap: true,
        textAlign: textAlignment);
  }

  static Widget bigTitle(String text,
      [Color colour = kTextLight,
      TextAlign textAlignment = TextAlign.center,
      TextOverflow tovf = TextOverflow.visible]) {
    return textBox(text, 2, 25, tovf, FontWeight.w800, textAlignment, colour);
  }

  static Widget heading1Text(String text,
      [TextAlign textAlignment = TextAlign.start,
      TextOverflow tovf = TextOverflow.visible]) {
    return textBox(text, 2, 25, tovf, FontWeight.w800, textAlignment, kText);
  }

  static Widget heading2Text(String text,
      [TextAlign textAlignment = TextAlign.start,
      TextOverflow tovf = TextOverflow.visible]) {
    return textBox(text, 0, 20, tovf, FontWeight.w500, textAlignment, kText);
  }

  static Widget heading3Text(String text,
      [TextAlign textAlignment = TextAlign.start,
      TextOverflow tovf = TextOverflow.visible]) {
    return textBox(text, 0, 16, tovf, FontWeight.w400, textAlignment, kText);
  }

  static Widget heading4Text(String text,
      [TextAlign textAlignment = TextAlign.start,
      TextOverflow tovf = TextOverflow.visible]) {
    return textBox(text, 0, 10.24, tovf, FontWeight.w400, textAlignment, kText);
  }

  static Widget heading5Text(String text,
      [TextAlign textAlignment = TextAlign.start,
      TextOverflow tovf = TextOverflow.visible]) {
    return textBox(text, 0, 10.24, tovf, FontWeight.w300, textAlignment, kText);
  }

  static Widget learningText(String text,
      [TextAlign textAlignment = TextAlign.start,
      TextOverflow tovf = TextOverflow.visible]) {
    return textBox(text, 2, 48.83, tovf, FontWeight.w700, textAlignment, kText);
  }

  static Widget learningHeading2Text(String text,
      [TextAlign textAlignment = TextAlign.start,
      TextOverflow tovf = TextOverflow.visible]) {
    return textBox(text, 0, 16, tovf, FontWeight.w600, textAlignment, kText);
  }

  static Widget learningHeading3Text(String text,
      [TextAlign textAlignment = TextAlign.start,
      TextOverflow tovf = TextOverflow.visible]) {
    return textBox(text, 0, 12.8, tovf, FontWeight.w400, textAlignment, kText);
  }
}
