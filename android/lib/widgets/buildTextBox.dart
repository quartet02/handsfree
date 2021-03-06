// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:handsfree/widgets/buildText.dart';
// import 'package:handsfree/widgets/constants.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class buildTextBox extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
//
//   static Widget authenticateTextBox(TextEditingController controllers,
//       String hint, bool blockText, bool autoCorrect, String errorMessage,
//       {EdgeInsets margins = const EdgeInsets.all(0)}) {
//     double radius = 25;
//     return Container(
//       margin: margins,
//       decoration: BoxDecoration(
//           color: Colors.transparent,
//           image: const DecorationImage(
//             image: AssetImage('assets/image/text_field.png'),
//             fit: BoxFit.cover,
//           ),
//           borderRadius: BorderRadius.circular(radius),
//           boxShadow: const [
//             BoxShadow(
//               color: kTextShadow,
//               offset: Offset(6, 6),
//               blurRadius: 6,
//             ),
//           ]),
//       child: TextFormField(
//         controller: controllers,
//         obscureText: blockText,
//         autocorrect: autoCorrect,
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(radius),
//             borderSide: const BorderSide(
//               width: 0,
//               style: BorderStyle.none,
//             ),
//           ),
//           hintText: hint,
//           labelStyle: GoogleFonts.montserrat(
//             fontSize: 12.8,
//             fontWeight: FontWeight.w400,
//             color: kTextFieldText,
//           ),
//           hintStyle: GoogleFonts.montserrat(
//             fontSize: 12.8,
//             fontWeight: FontWeight.w400,
//             color: kTextFieldText,
//           ),
//           fillColor: kTextLight,
//           filled: false,
//         ),
//         validator: (String? value) {
//           if (value == null || value.isEmpty) {
//             return errorMessage;
//           }
//           return null;
//         },
//       ),
//     );
//   }
//
//   static Widget textBox(
//     TextEditingController controllers,
//     String hint, {
//     TextInputAction? action,
//     TextInputType? inputType,
//     int? maxLine = 1,
//     EdgeInsets margins = const EdgeInsets.all(0),
//     EdgeInsets paddings = const EdgeInsets.symmetric(horizontal: 20.0),
//   }) {
//     double radius = 25;
//     return Container(
//       margin: margins,
//       decoration: BoxDecoration(
//           color: Colors.transparent,
//           image: const DecorationImage(
//             image: AssetImage('assets/image/text_field.png'),
//             fit: BoxFit.cover,
//           ),
//           borderRadius: BorderRadius.circular(radius),
//           boxShadow: const [
//             BoxShadow(
//               color: kTextShadow,
//               offset: Offset(6, 6),
//               blurRadius: 6,
//             ),
//           ]),
//       child: TextFormField(
//         controller: controllers,
//         textInputAction: action,
//         keyboardType: inputType,
//         maxLines: maxLine,
//         decoration: InputDecoration(
//           contentPadding: paddings,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(radius),
//             borderSide: const BorderSide(
//               width: 0,
//               style: BorderStyle.none,
//             ),
//           ),
//           hintText: hint,
//           labelStyle: GoogleFonts.montserrat(
//             fontSize: 12.8,
//             fontWeight: FontWeight.w400,
//             color: kTextFieldText,
//           ),
//           hintStyle: GoogleFonts.montserrat(
//             fontSize: 12.8,
//             fontWeight: FontWeight.w400,
//             color: kTextFieldText,
//           ),
//           fillColor: kTextLight,
//           filled: false,
//         ),
//       ),
//     );
//   }
//
//   static Widget passBox(TextEditingController controllers, String hint,
//       bool blockText, bool autoCorrect, String errorMessage, bool confirm) {
//     double radius = 25;
//     return Container(
//       decoration: BoxDecoration(
//           image: const DecorationImage(
//             image: AssetImage('assets/image/text_field.png'),
//             fit: BoxFit.cover,
//           ),
//           borderRadius: BorderRadius.circular(radius),
//           boxShadow: const [
//             BoxShadow(
//               color: kTextShadow,
//               offset: Offset(6, 6),
//               blurRadius: 6,
//             ),
//           ]),
//       child: TextFormField(
//         controller: controllers,
//         obscureText: blockText,
//         autocorrect: autoCorrect,
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(radius),
//             borderSide: const BorderSide(
//               width: 0,
//               style: BorderStyle.none,
//             ),
//           ),
//           hintText: hint,
//           labelStyle: GoogleFonts.montserrat(
//             fontSize: 12.8,
//             fontWeight: FontWeight.w400,
//             color: kTextFieldText,
//           ),
//           hintStyle: GoogleFonts.montserrat(
//             fontSize: 12.8,
//             fontWeight: FontWeight.w400,
//             color: kTextFieldText,
//           ),
//           fillColor: kTextLight,
//           filled: false,
//         ),
//         validator: (String? value) {
//           if (value == null || value.isEmpty) {
//             return 'Please retype your password';
//           } else if (controllers.text != controllers.text) {
//             return 'Password not same';
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class buildTextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget authenticateTextBox(TextEditingController controllers,
      String hint, bool blockText, bool autoCorrect, String errorMessage,
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

  static Widget textBox(
      TextEditingController controllers,
      String hint, {
        String selector = '',
        String uid = '',
        String initialValue = '',
        bool enabled = true,
        TextInputAction? action,
        TextInputType? inputType,
        int? maxLine = 1,
        EdgeInsets margins = const EdgeInsets.all(0),
        EdgeInsets paddings = const EdgeInsets.symmetric(horizontal: 20.0)
      }) {
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
        textInputAction: action,
        keyboardType: inputType,
        maxLines: maxLine,
        initialValue: initialValue,
        enabled: enabled,
        onFieldSubmitted: (txt) => DatabaseService(uid: uid).updateSingleData(selector, txt),
        controller: null,
        decoration: InputDecoration(
          contentPadding: paddings,
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