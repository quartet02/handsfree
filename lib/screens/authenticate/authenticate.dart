import 'package:flutter/material.dart';
import 'package:handsfree/screens/authenticate/signIn.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';
import '../../services/auth.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          // overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              left: 20,
              // top: 20,
              child: Container(
                // width: 400,
                // height: 300,
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  'assets/purple.svg',
                ),
              ),
            ),
            Positioned(
              // left: 20,
              // top: 20,
              child: Container(
                // width: 400,
                // height: 300,
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  'assets/yellow.svg',
                ),
              ),
            ),
            Container(
              // width: 400,
              // height: 300,
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                'assets/magenta.svg',
                fit: BoxFit.fill,
              ),
            ),
            const Text('Authenticate page'),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/auth/signIn');
                    },
                    child: const Text('Sign In')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/auth/signUp');
                    },
                    child: const Text('Sign Up')),
                ElevatedButton(
                    onPressed: () {
                      _auth.signInWithGoogle();
                    },
                    child: const Text('Sign In with Google')),
              ],
            ),
          ],
        ), //Stack
      ), //Center
    );
  }
}
