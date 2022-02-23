import 'dart:ui';
import 'package:handsfree/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:handsfree/utils/miscellaneous.dart';

bool isShowing = false;
OverlayEntry overlayEntry = OverlayEntry(builder: (context) => Container());

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
                    margin: const EdgeInsets.symmetric(vertical: 50),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 41),
                      alignment: Alignment.center,
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
                            margin: EdgeInsets.only(top: 10),
                            child: Container(
                              height: 250,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 20),
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
                          const Padding(padding: EdgeInsets.only(bottom: 20)),
                          buildText.heading1Text(title),
                          const Padding(padding: EdgeInsets.only(bottom: 20)),
                          buildText.heading2Text(desc),
                        ],
                      ),
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
