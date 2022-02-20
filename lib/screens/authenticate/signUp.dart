import 'package:flutter/material.dart';

import '../../services/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/sign_up.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 200),
          padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
          key: _signUpFormKey,
          child: Column(
            children: [
              Container(alignment: Alignment.centerLeft, child: Text('Email')),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 20),
                  child: Text('Password')),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some password';
                  }
                  return null;
                },
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 20),
                  child: Text('Confirm Password')),
              TextFormField(
                controller: repasswordController,
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Retype your password',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please retype your password';
                  } else if (passwordController.text !=
                      repasswordController.text) {
                    return 'Password not same';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_signUpFormKey.currentState!.validate()) {
                      dynamic results = await _auth.signUpWithEmailAndPassword(
                          emailController.text, passwordController.text);
                      if (results[0] == 1) {
                        // sign up fail
                        var snackBar = SnackBar(
                          content: Text(results[1]),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text("Sign up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
