import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/widgets/backButton.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:themed/themed.dart';
import '../../services/medialoader.dart';
import '../../widgets/backButton.dart';

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
          child: Stack(
            children: [
              Button.backButton(context, 30, 9.5,
                  popFunc: () => {
                        Navigator.of(context)
                            .popAndPushNamed('/dictionary', result: true)
                      }),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 40, bottom: 5, right: 50),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10),
                child: Column(
                  children: [
                    buildText.bigTitle("Dictionary"),
                    SizedBox(height: MediaQuery.of(context).size.height / 8),
                    Container(
                      height: MediaQuery.of(context).size.height / 2.3,
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
                          image: AssetImage('assets/image/dictionary_rect.png'),
                        ),
                      ),

                      // something happen here, dont know how to settle, just some annoying exception

                      child: FutureBuilder(
                          future: FireStorageService.loadImage(widget.imgUrl!),
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
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                try {
                                  return ChangeColors(
                                    brightness: 0.1,
                                    saturation: 0.2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          scale: 4,
                                          image: Image.network(
                                                  snapshot.data as String)
                                              .image,
                                        ),
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  return Container(
                                    child: Text(
                                      'Coming Soon!',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: kText,
                                      ),
                                    ),
                                  );
                                }
                              }
                            }
                            return Container(
                              child: Text(
                                'Error occured while loading iamge',
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: kText,
                                ),
                              ),
                            );
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
                          Text(widget.phoneticSymbol!),
                          const SizedBox(height: 20),
                          buildText.heading3Text(widget.definition!),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
