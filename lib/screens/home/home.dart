import 'package:flutter/material.dart';
import '../../services/database.dart';
import '../../widgets/navBar.dart';
import '../../services/auth.dart';
import '../../widgets/buildButton.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:math';

/*
* Help here:
*   1) onTap there, change the background image to the relevant imgUrl
* */

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List? _wordData = [];
  Map? _quiz = {};
  String _word = '';
  String _imgUrl = '';

  @override
  void initState() {
    _wordData = [];
    futureListConverter();
    super.initState();
  }

  void getQuiz() {
    Random r = new Random();
    _quiz = _wordData![r.nextInt(_wordData!.length - 1) + 1];
  }

  void futureListConverter() async {
    _wordData = await DatabaseService().getWordData();
  }

  @override
  Widget build(BuildContext context) {
    //check keyboard visibility
    final isVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    final AuthService _auth = AuthService();
    final homeFieldController = TextEditingController();
    const double radius = 25;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popAndPushNamed('/learn', result: true);
        return true;
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            getQuiz();
            _word = _quiz!['word'];
            debugPrint(_word);
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/image/home.png'),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Container(
                  alignment: const Alignment(0, 500),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 125, left: 60, right: 50),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/image/text_field.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(radius),
                              boxShadow: const [
                                BoxShadow(
                                  color: kTextShadow,
                                  offset: Offset(6, 6),
                                  blurRadius: 6,
                                ),
                              ]),
                          child: TextFormField(
                            focusNode: FocusNode(),
                            controller: TextEditingController(),
                            obscureText: false,
                            autocorrect: false,
                            onFieldSubmitted: (txt) {
                              debugPrint(_word);
                              debugPrint(txt);
                              if (txt.toLowerCase() == _word.toLowerCase()) {
                                debugPrint('Correct Answer');
                                getQuiz();
                                _word = _quiz!['word'];
                                debugPrint(_word);
                              } else if (_word
                                  .toLowerCase()
                                  .contains(txt.toLowerCase())) {
                                debugPrint('Partially Correct');
                                debugPrint('The full answer is: ' + _word);
                                getQuiz();
                                _word = _quiz!['word'];
                                debugPrint(_word);
                              } else {
                                debugPrint('Incorrect Answer');
                                debugPrint('Answer is: ' + _word);
                                debugPrint('Please try again!');
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(radius),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: "Tap Screen and Guess This Sign",
                              labelStyle: GoogleFonts.montserrat(
                                fontSize: 12.8,
                                fontWeight: FontWeight.w400,
                                color: kTextFieldText,
                              ),
                              hintStyle: GoogleFonts.montserrat(
                                fontSize: 12.8,
                                fontWeight: FontWeight.w400,
                                color: kTextFieldText,
                              ),
                              fillColor: kTextLight,
                              filled: false,
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter some text";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton:
            isVisible ? const SizedBox() : NavBar.Buttons(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBody: true,
        bottomNavigationBar: NavBar.bar(context, 0),
      ),
    );
  }
}
