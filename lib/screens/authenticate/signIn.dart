import 'package:flutter/material.dart';
import 'package:handsfree/services/auth.dart';
import 'package:handsfree/widgets/backButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/buildTextBox.dart';

import '../../widgets/backButton.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/sign_in.png'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Button.backButton(context, 30, 12.5),
            Container(
              margin: const EdgeInsets.only(top: 200),
              padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: buildText.labelText("Email"),
                  ),
                  buildTextBox.authenticateTextBox(
                      emailController,
                      'Enter your email',
                      false,
                      false,
                      'Please enter some text'),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    child: buildText.labelText("Password"),
                  ),
                  buildTextBox.authenticateTextBox(
                      passwordController,
                      'Enter your password',
                      true,
                      false,
                      'Please enter some password'),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/auth/forgetPassword");
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      alignment: Alignment.topLeft,
                      child: Text("Forget Passwords?",
                          style: GoogleFonts.montserrat(
                            fontSize: 12.8,
                            fontWeight: FontWeight.w300,
                            color: kText,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                          overflow: TextOverflow.visible),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GestureDetector(
                        onTap: () async {
                          if (true) {
                            dynamic results =
                                await _auth.signInWithEmailAndPassword(
                                    emailController.text,
                                    passwordController.text);
                            if (results[0] == 1) {
                              // login fail
                              var snackBar = const SnackBar(
                                content: Text("Login fail. Please try again."),
                                backgroundColor: kPurpleLight,
                              );

                              // Find the ScaffoldMessenger in the widget tree
                              // and use it to show a SnackBar.
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              Navigator.pushReplacementNamed(context, '/learn');
                            }
                          }
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
                                        color: kButtonShadow,
                                        offset: Offset(6, 6),
                                        blurRadius: 6,
                                      ),
                                    ]),
                                child: Image.asset(
                                  'assets/image/purple_button.png',
                                  scale: 4,
                                )),
                          ),
                          Container(
                            height: 40,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kTextLight,
                              ),
                            ),
                          ),
                        ])),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 30),
                  //   child: GestureDetector(
                  //       onTap: () async {
                  //         if (true) {
                  //           dynamic results = await _auth.resetPassword(
                  //               email: emailController.text);
                  //           if (results[0] == 1) {
                  //             // reset fail
                  //             var snackBar = const SnackBar(
                  //               content: Text("Reset fail. Please try again."),
                  //               backgroundColor: kPurpleLight,
                  //             );

                  //             // Find the ScaffoldMessenger in the widget tree
                  //             // and use it to show a SnackBar.
                  //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //           } else {
                  //             Navigator.pushReplacementNamed(context, '/signIn');
                  //           }
                  //         }
                  //       },
                  //       child: Stack(children: <Widget>[
                  //         Center(
                  //           child: Container(
                  //               alignment: Alignment.center,
                  //               width: 200,
                  //               decoration: const BoxDecoration(
                  //                   borderRadius:
                  //                       BorderRadius.all(Radius.circular(20)),
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                       color: kButtonShadow,
                  //                       offset: Offset(6, 6),
                  //                       blurRadius: 6,
                  //                     ),
                  //                   ]),
                  //               child: Image.asset(
                  //                 'assets/image/purple_button.png',
                  //                 scale: 4,
                  //               )),
                  //         ),
                  //         Container(
                  //           height: 40,
                  //           alignment: Alignment.center,
                  //           padding: const EdgeInsets.only(top: 10),
                  //           child: Text(
                  //             'Forget Password',
                  //             style: GoogleFonts.montserrat(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w600,
                  //               color: kTextLight,
                  //             ),
                  //           ),
                  //         ),
                  //       ])),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
