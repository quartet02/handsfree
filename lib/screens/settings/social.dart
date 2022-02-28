import 'package:flutter/material.dart';
import 'package:handsfree/widgets/buildButton.dart';
import 'package:handsfree/models/friends.dart';
import 'package:handsfree/widgets/overlay.dart';
import 'package:handsfree/widgets/navBar.dart';
import 'package:handsfree/widgets/smallCard.dart';
import 'package:provider/provider.dart';
import 'package:handsfree/widgets/buildText.dart';

import '../../provider/communityProvider.dart';
import '../../provider/newsFeedProvider.dart';
import 'package:handsfree/widgets/navBar.dart';

double friendSize = 70;
double coumminitySize = 150;

class Social extends StatefulWidget {
  const Social({Key? key}) : super(key: key);

  @override
  _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> {
  var overlayState = const Overlays();
  @override
  Widget build(BuildContext context) {
    final isVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommunityProvider()),
        ChangeNotifierProvider(create: (_) => NewsFeedProvider()),
      ],
      child: Scaffold(
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
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
              child: Column(
                children: [
                  buildText.bigTitle("Social"),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 10)),
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
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
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
                          ShaderMask(
                            shaderCallback: (Rect rect) {
                              return const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.purple,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.purple
                                ],
                                stops: [
                                  0.0,
                                  0.03,
                                  0.97,
                                  1.0
                                ], // 10% purple, 80% transparent, 10% purple
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstOut,
                            child: Container(
                                height: friendSize + 15,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: friends.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
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
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: buildText.heading4Text(
                                                    friends[index].friendName),
                                              ),
                                            ],
                                          ));
                                    })),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 50)),

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
                          ShaderMask(
                            shaderCallback: (Rect rect) {
                              return const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.purple,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.purple
                                ],
                                stops: [
                                  0.0,
                                  0.03,
                                  0.97,
                                  1.0
                                ], // 10% purple, 80% transparent, 10% purple
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstOut,
                            child: Container(
                              child: Consumer<CommunityProvider>(
                                  builder: (context, card, child) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: coumminitySize + 100,
                                    child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return SmallCard(
                                              id: card.cardDetails[index].id,
                                              communitySize: coumminitySize,
                                              communityImage: card
                                                  .cardDetails[index].images,
                                              communityTitle: card
                                                  .cardDetails[index]
                                                  .communityTitle,
                                              communityDesc: card
                                                  .cardDetails[index]
                                                  .communityDesc);
                                        }));
                              }),
                            ),
                          ),
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
                          ShaderMask(
                            shaderCallback: (Rect rect) {
                              return const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.purple,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.purple
                                ],
                                stops: [
                                  0.0,
                                  0.03,
                                  0.97,
                                  1.0
                                ], // 10% purple, 80% transparent, 10% purple
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstOut,
                            child: Container(
                              child: Consumer<NewsFeedProvider>(
                                  builder: (context, news, child) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: coumminitySize + 100,
                                    child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return SmallCard(
                                              id: news.cardDetails[index].id,
                                              communitySize: coumminitySize,
                                              communityImage: news
                                                  .cardDetails[index]
                                                  .newsFeedImages,
                                              communityTitle: news
                                                  .cardDetails[index]
                                                  .newsFeedTitle,
                                              communityDesc: news
                                                  .cardDetails[index]
                                                  .newsFeedDesc);
                                        }));
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
        floatingActionButton:
            isVisible ? const SizedBox() : NavBar.Buttons(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBody: true,
        bottomNavigationBar: NavBar.bar(context, 3),
      ),
    );
  }
}
