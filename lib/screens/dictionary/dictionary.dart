import 'package:flutter/material.dart';
import 'package:handsfree/utils/miscellaneous.dart';
import 'package:handsfree/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import '../navbar/navBar.dart';

class Dictionary extends StatefulWidget {
  const Dictionary({Key? key}) : super(key: key);
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  final searchController = TextEditingController();

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
          padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
          margin: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              buildText.headingText("Dictionary"),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              buildTextBox.textBox(
                  searchController, 'Search', false, false, ''),
              const Padding(
                padding: EdgeInsets.only(bottom: 80),
              ),
              GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/auth/' + word);
                  },
                  child: Stack(children: <Widget>[
                    Center(
                      child: Container(
                          alignment: Alignment.center,
                          width: 200,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: kTextDeep,
                                  offset: Offset(6, 6),
                                  blurRadius: 6,
                                ),
                              ]),
                          child: Image.asset(
                            'assets/image/translator.png',
                            scale: 4,
                          )),
                    ),
                  ])),
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
              ),
              Text(
                'Text-to-Sign',
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: kText,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
              ),
              Text(
                'Translator',
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: kText,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
              ),
              Text(
                'Now in BETA!',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: kText,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: navBar.Buttons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: navBar.bar(),
    );
  }
}
