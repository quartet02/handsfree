import 'package:flutter/material.dart';
import 'package:handsfree/provider/lessonCardProvider.dart';
import 'package:handsfree/screens/learn/choiceCard.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:provider/provider.dart';

class Choices extends StatelessWidget {
  const Choices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LessonCardProvider provider = Provider.of<LessonCardProvider>(context);
    final List<String> options = provider.getMcqOptions;

    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 7)),
        buildText.heading3Text("Please choose one if it."),
        Padding(padding: EdgeInsets.only(top: 5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 40)),
            ChoiceCard(header: options[0]),
            ChoiceCard(header: options[1]),
            ChoiceCard(header: options[2]),
            ChoiceCard(header: options[3]),
            Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 40)),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
      ],
    );
  }
}
