import 'package:flutter/material.dart';
import 'package:handsfree/services/auth.dart';
import 'package:handsfree/widgets/buildButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/buildTextBox.dart';

import '../learn/learn.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
              image: AssetImage('assets/image/forget_password.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 200),
          padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
          key: _formKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 10),
                child: buildText.labelText("Recovery Email"),
              ),
              buildText.heading3Text(
                  "A verification email will be sent to change your password."),
              buildTextBox.authenticateTextBox(
                  emailController,
                  'Enter your recovery email',
                  false,
                  false,
                  'Please enter some text'),
              // GestureDetector(
              //   onTap: () async {
              //     if (true) {
              //       dynamic results =
              //           await _auth.resetPassword(email: emailController.text);
              //       if (results[0] == 1) {
              //         // reset fail
              //         var snackBar = const SnackBar(
              //           content: Text("Reset fail. Please try again."),
              //           backgroundColor: kPurpleLight,
              //         );

              //         // Find the ScaffoldMessenger in the widget tree
              //         // and use it to show a SnackBar.
              //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
              //       } else {
              //         Navigator.pushReplacementNamed(context, '/signIn');
              //       }
              //     }
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.only(top: 20, left: 10),
              //     alignment: Alignment.topLeft,
              //     child: Text("Forget Passwords?",
              //         style: GoogleFonts.montserrat(
              //           fontSize: 12.8,
              //           fontWeight: FontWeight.w300,
              //           color: kText,
              //           fontStyle: FontStyle.italic,
              //         ),
              //         textAlign: TextAlign.start,
              //         softWrap: true,
              //         overflow: TextOverflow.visible),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: GestureDetector(
                    onTap: () async {
                      dynamic results = await _auth.resetPassword(
                          email: emailController.text);
                      if (results[0] == 1) {
                        // login fail
                        var snackBar = const SnackBar(
                          content:
                              Text("Reset password fail. Please try again"),
                          backgroundColor: kPurpleLight,
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        // login fail
                        var snackBar = const SnackBar(
                          content: Text(
                              "A change password email has been sent to you account."),
                          backgroundColor: kPurpleLight,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pushReplacementNamed(context, '/auth/signIn');
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
                          'Send email',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kTextLight,
                          ),
                        ),
                      ),
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
