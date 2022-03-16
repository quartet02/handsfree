import 'package:flutter/material.dart';
import 'package:handsfree/widgets/overlay.dart';
import 'package:handsfree/widgets/buildButton.dart';
import 'package:handsfree/widgets/buildText.dart';

import '../services/medialoader.dart';

class SmallCard extends StatelessWidget {
  final id;
  final communitySize;
  final communityImage;
  final communityTitle;
  final communityDesc;

  SmallCard(
      {required this.id,
      required this.communitySize,
      required this.communityImage,
      required this.communityTitle,
      required this.communityDesc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          margin: const EdgeInsets.only(right: 10),
          height: communitySize,
          width: communitySize,
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage('assets/image/medium_rect.png'),
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: communitySize,
                    width: communitySize,
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(top: 5.0),
                    child: FutureBuilder(
                        future: getImage(context, communityImage),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.height / 100,
                                  vertical:
                                      MediaQuery.of(context).size.height / 40),
                              child: snapshot.data as Widget,
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.height / 100,
                                  vertical:
                                      MediaQuery.of(context).size.height / 40),
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            print('Connection Failed');
                            return Container();
                          }
                        }),
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     alignment: Alignment.center,
                    //     image: AssetImage(communityImage),
                    //     scale: 4,
                    //   ),
                    // ),
                  ),
                  buildText.heading3Text(communityTitle),
                  buildText.heading5Text(communityDesc),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Overlays.showOverlay(context, id, communityImage,
                      communityTitle, communityDesc);
                },
              ),
            ],
          )),
    );
  }
}
