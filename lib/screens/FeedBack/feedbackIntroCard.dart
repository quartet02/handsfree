import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          padding: const EdgeInsets.only(bottom: 40),
          child: SvgPicture.asset(
            "assets/svg/feedback.svg",
            semanticsLabel: 'No result found',
            width: 150,
            height: 150,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText.heading3Text("We would love your feedback"),
              Breaker(i: 10),
              buildText.heading4Text(
                  "Our goal is to make a platform for everyone from different part of the world to learn sign language. Thus, we really care about your experience on using this application"),
              Breaker(i: 10),
              buildText.heading4Text("Your feedback is much appreciated!"),
              Breaker(i: 5),
            ],
          ),
        ),
      ],
    );
  }
}

/*
Headline :  We would love your feedback
Content : Our goal is to make a platform for everyone from different part of the world to learn 
          sign language. Thus, we really care about your experience on using this application
          
          Your feedback is much appreciated!
 */
