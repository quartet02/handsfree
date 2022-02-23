import 'package:flutter/material.dart';
import '../../widgets/navBar.dart';
import '../../services/auth.dart';
import '../../utils/buildButton.dart';
import 'package:handsfree/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //check keyboard visibility
    final isVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    final AuthService _auth = AuthService();
    final homeFieldController = TextEditingController();
    final double radius = 25;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/home.png'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Container(
              alignment: Alignment(0, 500),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 125, left: 60, right: 50),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: const DecorationImage(
                            image: AssetImage('assets/image/text_field.png'),
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
                        controller: homeFieldController,
                        obscureText: false,
                        autocorrect: false,
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
                          hintText: "aabbababbaba",
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
      floatingActionButton: isVisible ? SizedBox() : navBar.Buttons(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: navBar.bar(context),
    );
  }
}
