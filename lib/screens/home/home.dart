import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import '../navbar/navBar.dart';
import '../../services/auth.dart';
import '../../utils/miscellaneous.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final homeFieldController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/home.png'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Container(
              alignment: Alignment(0, 500),
              child: Stack(
                children: [
                  Cube(
                    interactive: false,
                    onSceneCreated: (Scene scene) {
                      scene.world.add(Object(
                          fileName: "assets/image/hand.obj",
                          position: Vector3(0, -0.2, 0),
                          rotation: Vector3(0, 180, 0)));
                      scene.camera.zoom = 10;
                    },
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: buildTextBox.textBox(
                      homeFieldController,
                      'Abababbababab',
                      false,
                      false,
                      'Please enter some text',
                      margins:
                          EdgeInsets.only(bottom: 125, left: 60, right: 60),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: navBar.Buttons(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: navBar.bar(context),
    );
  }
}
