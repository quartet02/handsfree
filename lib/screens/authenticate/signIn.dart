import 'package:flutter/material.dart';
import 'package:handsfree/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        child: Container(
          margin: const EdgeInsets.only(top: 200),
          padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
          key: _formKey,
          child: Column(
            children: [
              Container(alignment: Alignment.centerLeft, child: Text('Email')),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  fillColor: Colors.amber,
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic results = await _auth.signInWithEmailAndPassword(
                          emailController.text, passwordController.text);
                      if (results[0] == 1) {
                        // login fail
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
                  child: const Text("Sign in"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
