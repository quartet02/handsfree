import 'package:flutter/material.dart';
import 'package:handsfree/widgets/buildText.dart';

import '../../widgets/backButton.dart';

class Acknowledgement extends StatelessWidget {
  const Acknowledgement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/purple_heading2.png'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Button.backButton(context, 30, 9.5),
            Container(
              padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildText.bigTitle("Acknowledgement"),
                  breaker(MediaQuery.of(context).size.height / 12),
                  ShaderMask(
                    shaderCallback: (Rect rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.purple,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.purple
                        ],
                        stops: [
                          0.0,
                          0.1,
                          0.9,
                          1.0
                        ], // 10% purple, 80% transparent, 10% purple
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstOut,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          const EdgeInsets.only(left: 0, bottom: 5, right: 0),
                      height: MediaQuery.of(context).size.height / 1.37,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          buildText.heading2Text(
                              "We use these open source libraries to make Handsfree"),
                          breaker(20),
                          buildText.heading3Text("""
- async
- autocomplete_textfield
- camera
- cloud_firestore
- cloud_functions
- confetti
- cupertino_icons
- cupertino_will_pop_scope
- expandable
- file_picker
- firebase_auth
- firebase_core
- firebase_database
- firebase_storage
- firebase_messaging
- flamingo
- flamingo_annotation
- fluttertoast 
- flutter_cube
- flutter_polygon
- flutter_spinkit
- flutter_svg
- flutter_typeahead
- flutter_webrtc
- gallery_saver
- google_fonts
- google_sign_in
- intl
- page_transition
- path_provider
- percent_indicator
- provider
- rxdart
- themed
- shared_preferences
- simple_shadow
- video_player
- image_picker"""),
                          breaker(50),
                          buildText.heading2Text("Contributors"),
                          breaker(20),
                          buildText.heading3Text("4 ducks"),
                          breaker(30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget breaker(double i) {
    return Padding(
      padding: EdgeInsets.only(bottom: i),
    );
  }
}
