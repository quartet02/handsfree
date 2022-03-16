import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handsfree/screens/social/onlineFriendList.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/overlay.dart';
import 'package:handsfree/widgets/navBar.dart';
import 'package:handsfree/widgets/smallCard.dart';
import 'package:provider/provider.dart';
import 'package:handsfree/widgets/buildText.dart';

import '../../models/newsFeedModel.dart';
import '../../provider/newsFeedProvider.dart';
import '../../widgets/loading.dart';

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
    // prevent screen rotation and force portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return StreamBuilder<List<NewsFeedModel>?>(
      stream: DatabaseService().newsList,
      builder: (context, snapshot){
        if(snapshot.hasData){
          List<NewsFeedModel>? newsList = snapshot.data;

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => NewsFeedProvider()),
            ],
            child: Scaffold(
              body: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(30, 160, 30, 0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText.heading2Text("Online Friends"),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            Navigator.pushNamed(
                                                context, "/viewFriendRequest");
                                          },
                                          child: Container(
                                            width: 28,
                                            height: 28,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                alignment: Alignment.center,
                                                image: AssetImage(
                                                    'assets/image/friend_request.png'),
                                                scale: 3,
                                              ),
                                            ),
                                            child: Container(),
                                          ),
                                        ),
                                        Breaker(i: 5, pos: PadPos.right),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/searchGlobalUsers");
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
                                    )
                                  ],
                                ),
                                Breaker(i: 5),
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
                                  child: const OnlineFriendList(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.fromLTRB(30, 10, 30, 40),
                              child: buildNewsFeed(newsList!)),
                        ],
                      ),
                    ],
                  ),
                  buildHeading(),
                ],
              ),
              floatingActionButton:
              isVisible ? const SizedBox() : NavBar.Buttons(context),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              extendBody: true,
              bottomNavigationBar: NavBar.bar(context, 3),
            ),
          );
        }
        else{
          return Loading();
        }
      }
    );
  }

  Widget buildHeading() {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
              maxHeight: 172, minWidth: MediaQuery.of(context).size.width),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/orange_heading4.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
            alignment: Alignment.topCenter,
            child: buildText.bigTitle("Social"))
      ],
    );
  }

  Widget buildNewsFeed(List<NewsFeedModel> newsList) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildText.heading2Text("News Feed"),
          GestureDetector(
            onTap: () async {
              Navigator.pushNamed(context, "/news");
            },
            child: Container(
              width: 40,
              height: 25,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage('assets/image/search_icon.png'),
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
              0.02,
              0.98,
              1.0
            ], // 10% purple, 80% transparent, 10% purple
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: Container(
          child: Consumer<NewsFeedProvider>(builder: (context, news, child) {

            news.setNewsFeedModel(newsList);
            int length = newsList.length;

            return Container(
              width: MediaQuery.of(context).size.width,
              height: coumminitySize + 100,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: length<5 ? length : 5,
                  itemBuilder: (context, index) {
                    return SmallCard(
                        id: news.cardDetails[index].id,
                        communitySize: coumminitySize,
                        communityImage: news.cardDetails[index].newsFeedImages,
                        communityTitle: news.cardDetails[index].newsFeedTitle,
                        communityDesc: news.cardDetails[index].newsFeedDesc);
                  }),
            );
          }),
        ),
      ),
    ]);
  }
}
