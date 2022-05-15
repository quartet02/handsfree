import 'package:flutter/material.dart';
import 'package:handsfree/provider/lessonCardProvider.dart';
import 'package:handsfree/screens/learn/choiceCard.dart';
import 'package:provider/provider.dart';

class Choices extends StatelessWidget {
  final List<String> options;

  const Choices({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LessonCardProvider provider = Provider.of<LessonCardProvider>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ChoiceCard(header: options[0]),
            ChoiceCard(header: options[1])
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ChoiceCard(header: options[2]),
            ChoiceCard(header: options[3])
          ],
        )
      ],
    );
  }
}
