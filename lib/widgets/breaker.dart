import 'package:flutter/material.dart';
import 'package:handsfree/widgets/constants.dart';

class Breaker extends StatelessWidget {
  Breaker({required this.i, this.pos = PadPos.bottom});

  final double i;
  final PadPos pos;

  @override
  Widget build(BuildContext context) {
    if (pos == PadPos.bottom) {
      return Padding(
        padding: EdgeInsets.only(bottom: i),
      );
    } else if (pos == PadPos.left) {
      return Padding(
        padding: EdgeInsets.only(left: i),
      );
    } else if (pos == PadPos.right) {
      return Padding(
        padding: EdgeInsets.only(right: i),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: i),
      );
    }
  }
}
