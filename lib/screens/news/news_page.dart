import 'package:flutter/material.dart';
import 'package:handsfree/models/newsFeedModel.dart';
import 'package:handsfree/services/medialoader.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:intl/intl.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsFeedModel news =
        ModalRoute.of(context)!.settings.arguments as NewsFeedModel;
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          ListView(physics: const BouncingScrollPhysics(), children: [
            Column(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(30, 160, 30, 80),
                child: Column(children: [
                  buildAuthorCard(context, news),
                  Breaker(i: 20),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.height * 0.3 * 16 / 9,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            Image.network(news.newsFeedImages as String).image,
                      ),
                    ),
                  ),
                  Breaker(i: 20),
                  Container(child: buildText.heading3Text(news.newsFeedDesc)),
                ]),
              ),
            ]),
          ]),
          buildHeading(context, news)
        ],
      ),
    );
  }

  Widget buildAuthorCard(BuildContext context, NewsFeedModel news) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage("assets/image/learning_small_rect.png"),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
              color: kTextShadow,
              offset: Offset(5, 6),
              spreadRadius: 1,
              blurRadius: 8)
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(news.authorPic as String).image,
                  ),
                ),
              ),
            ),
            Breaker(i: 20, pos: PadPos.right),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildText.heading3Text(news.author),
                  Breaker(i: 3),
                  buildText.heading4Text(DateFormat('yyyy-MM-dd - kk:mm')
                      .format(news.timestamp.toDate())),
                ]),
          ],
        )
      ]),
    );
  }

  Widget buildHeading(BuildContext context, NewsFeedModel news) {
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
            padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
            alignment: Alignment.topCenter,
            child: buildText.bigTitle(news.newsFeedTitle))
      ],
    );
  }
}
