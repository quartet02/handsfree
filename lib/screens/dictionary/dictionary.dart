import 'package:flutter/material.dart';

class Dictionary extends StatelessWidget {
  const Dictionary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/image/magenta_heading.png'),
            fit: BoxFit.cover),
      ),
      margin: const EdgeInsets.only(bottom: 40),
    );
  }
}
