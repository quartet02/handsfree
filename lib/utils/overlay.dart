import 'dart:ui';
import 'package:handsfree/utils/constants.dart';
import 'package:flutter/material.dart';

bool isShowing = false;
OverlayEntry? overlayEntry;

class Overlays extends StatelessWidget {
  static showOverlay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
              child: GestureDetector(
                onTap: () async {
                  isShowing = true;
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 50),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 41),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: kTextShadow,
                          offset: Offset(6, 6),
                          blurRadius: 6,
                        ),
                      ],
                      image: const DecorationImage(
                        alignment: Alignment.center,
                        image: AssetImage('assets/image/overlay_rect.png'),
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
    await close();
    await Future.delayed(Duration(seconds: 2));
    // if (isShowing) {
    overlayEntry.remove();
    // }
  }

  static Future close() async {
    if (!isShowing) {
      await Future.delayed(const Duration(milliseconds: 12));
      return close();
    } else {
      overlayEntry?.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
