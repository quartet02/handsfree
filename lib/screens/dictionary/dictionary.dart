import 'package:flutter/material.dart';
import 'package:handsfree/provider/dictionaryProvider.dart';
import 'package:handsfree/screens/dictionary/searchBar.dart';
import 'package:handsfree/screens/dictionary/searchGroup.dart';
import 'package:handsfree/widgets/buildButton.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../widgets/navBar.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/navBar.dart';

class Dictionary extends StatefulWidget {
  const Dictionary({Key? key}) : super(key: key);
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return ChangeNotifierProvider<DictionaryProvider>(
      create: (context) => DictionaryProvider(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/image/magenta_heading.png'),
                fit: BoxFit.cover),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
            child: Column(
              children: [
                buildText.bigTitle("Dictionary"),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Stack(
                  children: [
                    isVisible ? const SearchGroup() : Container(),
                    const SearchBar()
                  ],
                ),
                !isVisible
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 80),
                      )
                    : Container(),
                !isVisible
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/translator');
                        },
                        child: Stack(
                          children: <Widget>[
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                !isVisible
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                      )
                    : Container(),
                !isVisible
                    ? Text(
                        'Text-to-Sign',
                        style: GoogleFonts.montserrat(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: kText,
                        ),
                      )
                    : Container(),
                !isVisible
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                      )
                    : Container(),
                !isVisible
                    ? Text(
                        'Translator',
                        style: GoogleFonts.montserrat(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: kText,
                        ),
                      )
                    : Container(),
                !isVisible
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                      )
                    : Container(),
                !isVisible
                    ? Text(
                        'Now in BETA!',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: kText,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        floatingActionButton: isVisible ? SizedBox() : NavBar.Buttons(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBody: true,
        bottomNavigationBar: NavBar.bar(context),
      ),
    );
  }
}
