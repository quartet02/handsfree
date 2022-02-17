import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Home'),
            ElevatedButton(
            onPressed: () {
              _auth.signOut();
            },
            child: Text('Sign Out'),
          ),]
        ),
      ),
    );
  }
}
