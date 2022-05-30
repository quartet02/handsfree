import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget backButton(BuildContext context, double left, double height) {
    return Positioned(
      left: left,
      top: MediaQuery.of(context).size.height / height,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context, true);
        },
        child: Container(
          height: 20,
          width: 15,
          decoration: const BoxDecoration(
            image: DecorationImage(
                // alignment: Alignment.topLeft,
                image: AssetImage('assets/image/back_button.png'),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  static Widget blackBackButton(
      BuildContext context, double left, double height) {
    return Positioned(
      left: left,
      top: MediaQuery.of(context).size.height / height,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context, true);
        },
        child: Container(
          height: 20,
          width: 15,
          decoration: const BoxDecoration(
            image: DecorationImage(
                // alignment: Alignment.topLeft,
                image: AssetImage('assets/image/black_back_button.png'),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
