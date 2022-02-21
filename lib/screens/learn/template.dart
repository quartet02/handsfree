import 'package:flutter/material.dart';

class Congratulation extends StatefulWidget {
  const Congratulation({Key? key}) : super(key: key);

  @override
  _CongratulationState createState() => _CongratulationState();
}

class _CongratulationState extends State<Congratulation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/purple_background.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
            margin: const EdgeInsets.only(top: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
            )),
      ),
    );
  }
}
