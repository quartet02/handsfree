import 'package:flutter/material.dart';
import 'package:handsfree/widgets/buildText.dart';

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
        child: Container(
          padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
          child: Column(
            children: [
              buildText.bigTitle("Acknowledgement"),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  breaker(80),
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
                  buildText.heading3Text("4 ducks")
                ],
              ),
            ],
          ),
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
