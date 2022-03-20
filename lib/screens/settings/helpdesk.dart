import 'package:flutter/material.dart';
import 'package:handsfree/provider/helpdeskProvider.dart';
import 'package:handsfree/screens/dictionary/searchBar.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/expandableCardList.dart';
import 'package:provider/provider.dart';

class HelpDesk extends StatefulWidget {
  const HelpDesk({Key? key}) : super(key: key);

  @override
  _HelpDeskState createState() => _HelpDeskState();
}

class _HelpDeskState extends State<HelpDesk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/purple_heading2.png"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 30, bottom: 5, right: 30),
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              buildText.bigTitle("Help Desk"),
              Breaker(i: 40),
              const SearchBar(
                prompt: "Search for possible solution",
                provider: Providers.helpdesk,
              ),
              Breaker(i: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                alignment: Alignment.centerLeft,
                child: buildText.heading3Text("Suggested Content"),
              ),
              // suggested solution content
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
                child: Consumer<HelpDeskProvider>(
                    builder: (context, topics, child) {
                  return ExpandableCardList(topicData: topics.topics);
                }),
              ),
            ],
          ),
        ),
      ),
      //),
    );
  }
}
