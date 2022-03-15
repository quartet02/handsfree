import 'package:flutter/material.dart';
import 'package:handsfree/models/chatModel.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';

class FriendBlock extends StatelessWidget {
  const FriendBlock(
      {Key? key,
      required this.roomData,
      required this.blockHeight,
      this.isFirst = false})
      : super(key: key);

  final double blockHeight;
  final ChatRoom roomData;
  final bool isFirst;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                isFirst
                    ? Navigator.pushNamed(context, "/chatHome")
                    : Navigator.pushNamed(context, "/chatHome/chat",
                        arguments: roomData);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                height: blockHeight,
                width: blockHeight * 1.1,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image/chat_bubble.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: isFirst
                    ? Container(
                        child: const Icon(
                          Icons.chat_bubble,
                          color: Colors.black,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(roomData.roomPicture),
                              fit: BoxFit.cover),
                        ),
                      ),
              ),
            ),
            Breaker(i: 5),
            buildText.heading5Text(isFirst ? "" : roomData.roomName),
          ],
        ));
  }
}
