import 'package:flutter/material.dart';

class Breaker extends StatelessWidget {
  double i;

  Breaker({required this.i});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: this.i),
    );
  }
}
