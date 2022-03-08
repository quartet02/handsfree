import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/widgets/buildButton.dart';
import '../../services/auth.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/greeting_page.png'),
              fit: BoxFit.cover),
        ),
        margin: const EdgeInsets.only(bottom: 0),
        child: Stack(
          fit: StackFit.expand,
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          // overflow: Overflow.visible,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildButton(
                      text: 'Sign in',
                      word: '/auth/signIn',
                      buttonColor: 'white'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildButton(
                      text: 'Sign up',
                      word: '/auth/signUp',
                      buttonColor: 'purple'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Sign in/up with',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            // _auth.signInWithFacebook();
                          },
                          child: Image.asset('assets/image/facebook_icon.png',
                              scale: 4)),
                      GestureDetector(
                          onTap: () {
                            _auth.signInWithGoogle();
                          },
                          child: Image.asset('assets/image/google_icon.png',
                              scale: 4)),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
