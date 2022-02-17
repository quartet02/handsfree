import 'package:flutter/material.dart';
import 'package:handsfree/screens/authenticate/signIn.dart';

import '../../services/auth.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
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
                  child: const Text('Sign In with Google'))
            ],
          ),
        ],
      ),
    ));
  }
}
