import 'dart:ui';
import 'package:handsfree/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:handsfree/widgets/buildText.dart';

bool isShowing = false;
OverlayEntry overlayEntry = OverlayEntry(builder: (context) => Container());

@deprecated
class Overlays extends StatelessWidget {
  const Overlays({Key? key}) : super(key: key);

  static showOverlay(BuildContext context, int id, String image, String title,
      String desc) async {
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Scaffold(
          body: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
                child: GestureDetector(
                  onTap: () {
                    dismissMenu();
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width / 8,
                        MediaQuery.of(context).size.height / 5,
                        MediaQuery.of(context).size.width / 8,
                        MediaQuery.of(context).size.height / 6),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 20),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: kTextShadow,
                          offset: Offset(6, 6),
                          blurRadius: 6,
                        ),
                      ],
                      image: DecorationImage(
                        alignment: Alignment.center,
                        image: AssetImage('assets/image/overlay_rect.png'),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          // margin: EdgeInsets.only(
                          //     top: MediaQuery.of(context).size.height / 10.5),
                          child: Container(
                            height: 250,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                alignment: Alignment.center,
                                image: AssetImage(image),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 5,
                                right: MediaQuery.of(context).size.width / 6,
                                bottom: 20)),
                        buildText.heading1Text(title),
                        Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 5,
                                right: MediaQuery.of(context).size.width / 6,
                                bottom: 20)),
                        buildText.heading3Text(desc),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlayState?.insert(overlayEntry);
  }

  static void dismissMenu() {
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
