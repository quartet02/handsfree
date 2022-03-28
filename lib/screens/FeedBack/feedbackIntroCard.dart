import 'package:flutter/material.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';

class FeedbackIntroCard extends StatelessWidget {
  const FeedbackIntroCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText.heading2Text("We would love your feedback"),
              Breaker(i: 10),
              buildText.heading3Text(
                  "Our goal is to make a platform for everyone from different part of the world to learn sign language. Thus, we really care about your experience on using this application"),
              Breaker(i: 10),
              buildText.heading3Text("Your feedback is much appreciated!"),
              Breaker(i: 20),
            ],
          ),
        ),
      ],
    );
  }
}
