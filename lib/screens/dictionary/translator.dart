import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:handsfree/screens/learn/congrats.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/loadingWholeScreen.dart';

import '../../services/medialoader.dart';

class Translator extends StatefulWidget {
  final String? word;
  final String? definition;
  final String? phoneticSymbol;
  final String? imgUrl;
  const Translator(
      this.word, this.definition, this.phoneticSymbol, this.imgUrl);

  @override
  _TranslatorState createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  String word = "Hello";
  String definition = "haha";
  String phoneticSymbol = "ababa";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popAndPushNamed('/dictionary', result: true);
        return true;
      },
      child: Scaffold(
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
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
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

                  // something happen here, dont know how to settle, just some annoying exception

                  child: FutureBuilder(
                      future: getImage(widget.imgUrl!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: MediaQuery.of(context).size.width / 1.2,
                            child: const CircularProgressIndicator(
                              strokeWidth: 1.0,
                            ),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.width / 1.2,
                              child: snapshot.data as Widget,
                            );
                          }
                        }
                        print(
                            'Image Path Does Not Exist in Firebase Storage -- Please Update Firebase');
                        return Container();
                      }),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      buildText.learningText(widget.word!),
                      buildText.heading2Text(widget.phoneticSymbol!),
                      const SizedBox(height: 20),
                      buildText.heading3Text(widget.definition!),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
