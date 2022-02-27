import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';

class Translator extends StatefulWidget {
  const Translator({Key? key}) : super(key: key);

  @override
  _TranslatorState createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  String word = "Hello";
  String definition = "haha";
  String phoneticSymbol = "ababa";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/magenta_heading.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
          child: Column(
            children: [
              buildText.bigTitle("Translator"),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height / 2.4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: kTextShadow,
                      offset: Offset(10, 10),
                      blurRadius: 20,
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/image/learning_big_rect.png'),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    buildText.learningText(word),
                    buildText.heading2Text(phoneticSymbol),
                    const SizedBox(height: 20),
                    buildText.heading3Text(definition),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
