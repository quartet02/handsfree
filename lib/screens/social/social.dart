import 'package:flutter/material.dart';
import 'package:handsfree/utils/miscellaneous.dart';
import 'package:handsfree/models/friends.dart';
import 'package:handsfree/models/community.dart';
import 'package:handsfree/models/newsFeed.dart';
import 'package:handsfree/utils/overlay.dart';

double friendSize = 70;
double coumminitySize = 150;

class Social extends StatefulWidget {
  const Social({Key? key}) : super(key: key);

  @override
  _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/orange_heading.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 45, bottom: 5, right: 46),
            margin: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                buildText.headingText("Social"),
                Padding(padding: EdgeInsets.only(top: 100)),
                Container(
                  height: 450,
                  child: ListView(
                    physics: BouncingScrollPhysics(),

                    scrollDirection: Axis.vertical,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildText.heading2Text("Online Friends"),
                          GestureDetector(
                            onTap: () async {
                              //check index and go the the respective place
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: AssetImage(
                                      'assets/image/search_icon.png'),
                                  scale: 3,
                                ),
                              ),
                              child: Container(),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      Container(
                          height: friendSize + 15,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: friends.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: friendSize,
                                    width: friendSize,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        alignment: Alignment.topCenter,
                                        image: AssetImage(
                                            'assets/image/chat_bubble.png'),
                                        scale: 3,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: friendSize,
                                          width: friendSize,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              alignment: Alignment.center,
                                              image: AssetImage(
                                                  friends[index].images),
                                              scale: 3,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 15,
                                          width: friendSize,
                                          alignment: Alignment.bottomCenter,
                                          child: buildText.heading4Text(
                                              friends[index].friendName),
                                        ),
                                      ],
                                    ));
                              })),
                      Padding(padding: EdgeInsets.only(top: 50)),

                      //Community
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildText.heading2Text("Community"),
                          GestureDetector(
                            onTap: () async {
                              //search community
                            },
                            child: Container(
                              width: 40,
                              height: 25,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: AssetImage(
                                      'assets/image/search_icon.png'),
                                  scale: 3,
                                ),
                              ),
                              child: Container(),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          height: coumminitySize + 100,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: communities.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    Overlays.showOverlay(
                                      context,
                                    );
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      height: coumminitySize,
                                      width: coumminitySize,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          alignment: Alignment.center,
                                          image: AssetImage(
                                              'assets/image/medium_rect.png'),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: coumminitySize,
                                            width: coumminitySize,
                                            alignment: Alignment.topCenter,
                                            margin:
                                                const EdgeInsets.only(top: 5.0),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                alignment: Alignment.center,
                                                image: AssetImage(
                                                    communities[index].images),
                                                scale: 4,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: coumminitySize,
                                            width: coumminitySize,
                                            alignment: Alignment.bottomCenter,
                                            child: buildText.heading3Text(
                                                communities[index]
                                                    .communityTitle),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 120),
                                            height: coumminitySize + 70,
                                            width: coumminitySize,
                                            alignment: Alignment.center,
                                            child: buildText.heading5Text(
                                                communities[index]
                                                    .communityDesc),
                                          ),
                                        ],
                                      )),
                                );
                              })),
                      //News Feed
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildText.heading2Text("News Feed"),
                          GestureDetector(
                            onTap: () async {
                              //check index and go the the respective place
                            },
                            child: Container(
                              width: 40,
                              height: 25,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: AssetImage(
                                      'assets/image/search_icon.png'),
                                  scale: 3,
                                ),
                              ),
                              child: Container(),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          height: coumminitySize + 100,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: communities.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: coumminitySize,
                                    width: coumminitySize,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        alignment: Alignment.center,
                                        image: AssetImage(
                                            'assets/image/medium_rect.png'),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: coumminitySize,
                                          width: coumminitySize,
                                          alignment: Alignment.topCenter,
                                          margin:
                                              const EdgeInsets.only(top: 5.0),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              alignment: Alignment.center,
                                              image: AssetImage(newsFeeds[index]
                                                  .newsFeedImages),
                                              scale: 4,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: coumminitySize,
                                          width: coumminitySize,
                                          alignment: Alignment.bottomCenter,
                                          child: buildText.heading3Text(
                                              newsFeeds[index].newsFeedTitle),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 120),
                                          height: coumminitySize + 70,
                                          width: coumminitySize,
                                          alignment: Alignment.center,
                                          child: buildText.heading5Text(
                                              newsFeeds[index].newsFeedDesc),
                                        ),
                                      ],
                                    ));
                              })),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
