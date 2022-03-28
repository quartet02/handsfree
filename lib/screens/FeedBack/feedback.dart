import 'package:flutter/material.dart';
import 'package:handsfree/screens/FeedBack/feedbackIntroCard.dart';
import 'package:handsfree/screens/FeedBack/getInTouch.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';

class FeedBack extends StatelessWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/purple_heading2.png"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 30, bottom: 5, right: 30),
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              buildText.bigTitle("Feedback"),
              Breaker(i: 80),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.purple,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.purple
                      ],
                      stops: [
                        0.0,
                        0.1,
                        0.9,
                        1.0
                      ], // 10% purple, 80% transparent, 10% purple
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: Container(
                    child: ListView(
                      padding: const EdgeInsets.only(
                          bottom: 50, left: 10, right: 10),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Breaker(i: 30),
                        const FeedbackIntroCard(),
                        const GetInTouchForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
