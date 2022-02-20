import 'package:flutter/material.dart';
import 'package:handsfree/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class buildButton extends StatelessWidget {
  final String text;
  final String word;
  final String style;

  buildButton({
    required this.text,
    required this.word,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 160.0,
      height: 40.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/auth/' + word);
          },
          child: Text(text)),
    );
  }
}

class buildTextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget textBox(TextEditingController controllers, String hint,
      bool blockText, bool autoCorrect, String errorMessage) {
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
              offset: Offset(10, 10),
              blurRadius: 20,
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
              offset: Offset(10, 10),
              blurRadius: 20,
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
}

class buildText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget text(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          // textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: kText,
        ),
      ),
    );
  }
}
