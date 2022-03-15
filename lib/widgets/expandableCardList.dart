import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';

class ExpandableCardList extends StatelessWidget {
  const ExpandableCardList({Key? key, required this.topicData})
      : super(key: key);

  final List topicData;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: topicData.isNotEmpty
          ? ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          itemCount: topicData.length,
          itemBuilder: (context, index) {
            return ExpandableNotifier(
              child: Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ScrollOnExpand(
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      tapBodyToCollapse: true,
                      tapHeaderToExpand: true,
                      tapBodyToExpand: true,
                    ),
                    header: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: buildText.heading3Text(topicData[index].title),
                    ),
                    expanded: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildText.textBox(
                              topicData[index].content,
                              0.2,
                              13,
                              FontWeight.w400,
                              TextAlign.justify,
                              kText),
                        ],
                      ),
                    ),
                    collapsed: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: buildText.textBox(
                          "Author: " + topicData[index].author,
                          0.2,
                          13,
                          FontWeight.w500,
                          TextAlign.start,
                          kText),
                    ),
                  ),
                ),
              ),
            );
          })
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/not_found.svg",
            semanticsLabel: 'No result found',
            width: 150,
            height: 150,
          ),
          Breaker(i: 12),
          buildText.textBox("No result found...", 0.5, 15,
              FontWeight.w400, TextAlign.start, kText),
          Breaker(i: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildText.textBox("Try contact us at ", 0.5, 15,
                  FontWeight.w400, TextAlign.start, kText),
              GestureDetector(
                child: buildText.textBox("here", 0.5, 15, FontWeight.w400,
                    TextAlign.start, kPurpleLight),
                onTap: () => Navigator.pushNamed(context, "/feedback"),
              ),
            ],
          ),
          Breaker(i: 100),
        ],
      ),
    );
  }
}