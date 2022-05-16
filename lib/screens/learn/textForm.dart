import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:provider/provider.dart';

import '../../provider/lessonCardProvider.dart';

class TextForm extends StatefulWidget {
  const TextForm({Key? key}) : super(key: key);

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LessonCardProvider provider = Provider.of<LessonCardProvider>(context);
    provider.submissionTriggerFunction = _controller.clear;

    return TextField(
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(25),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        hintText: "Your answer",
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
      controller: _controller,
      onChanged: (String value){
        provider.setQuesInput = value;
      },
      onSubmitted: (String value) async {
        provider.checkAns();
      },
    );
  }
}
