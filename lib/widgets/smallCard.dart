import 'package:flutter/material.dart';
import 'package:handsfree/models/newsFeedModel.dart';
import 'package:handsfree/widgets/overlay.dart';
import 'package:handsfree/widgets/buildButton.dart';
import 'package:handsfree/widgets/buildText.dart';

import '../services/medialoader.dart';

class SmallCard extends StatelessWidget {
  final NewsFeedModel news;
  final communitySize;

  SmallCard({
    required this.news,
    required this.communitySize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      future: FireStorageService.loadImage(news.newsFeedImages),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.height / 100,
                                  vertical:
                                      MediaQuery.of(context).size.height / 40),
                              child: Container(
                                  decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(snapshot.data as String)
                                      .image,
                                ),
                              )));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height / 100,
                                vertical:
                                    MediaQuery.of(context).size.height / 40),
                            child: const CircularProgressIndicator(),
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
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 20),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        buildText.heading3Text(news.newsFeedTitle),
                      ],
                    )),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Overlays.showOverlay(context, id, communityImage,
                //     communityTitle, communityDesc);
                Navigator.pushNamed(context, "/showNews", arguments: news);
              },
            ),
          ],
        ));
  }
}
