import 'package:flutter/material.dart';
import 'package:handsfree/screens/authenticate/signIn.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handsfree/utils/constants.dart';
import 'package:handsfree/utils/miscellaneous.dart';
import 'package:simple_shadow/simple_shadow.dart';
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
        margin: const EdgeInsets.only(bottom: 40),
        child: Stack(
          fit: StackFit.expand,

          // clipBehavior: Clip.antiAliasWithSaveLayer,
          // overflow: Overflow.visible,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: buildButton(
                      text: 'Sign in', word: 'signIn', style: 'white'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: buildButton(
                      text: 'Sign up', word: 'signUp', style: 'purple'),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Sign in/up with',
                  ),
                ),
                Row(
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
