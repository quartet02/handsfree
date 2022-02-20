import 'package:flutter/material.dart';

class buildButton extends StatelessWidget {
  final String text;
  final String word;
  final String style;

  buildButton({
    required this.text,
    required this.word,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 160.0,
      height: 40.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/auth/' + word);
          },
          child: Text(text)),
    );
  }
}
