import 'package:flutter/material.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = 0.6;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/white_background.png'),
              fit: BoxFit.cover),
        ),
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, top: 14),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.center,
                      image: AssetImage('assets/image/square_background.png'),
                      scale: 4),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.center,
                      image: AssetImage('assets/image/loading.gif'),
                      scale: 6),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 220),
                alignment: Alignment.center,
                child: Container(
                  width: 210,
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: LinearPercentIndicator(
                      animateFromLastPercent: true,
                      animationDuration: 1,
                      percent: progress,
                      lineHeight: 8,
                      progressColor: kOrangeDeep,
                      animation: true),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 280),
                  child: buildText.heading2Text("Loading...")),
            ],
          ),
        ),
      ),
    );
  }
}