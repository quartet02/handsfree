import 'package:flutter/material.dart';
import '../navbar/navBar.dart';
import '../../services/auth.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/home.png'),
              fit: BoxFit.cover),
        ),
      ),
      floatingActionButton: navBar.Buttons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: navBar.bar(),
    );
  }
}
