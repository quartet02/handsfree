import 'package:flutter/material.dart';
import 'package:handsfree/models/chatModel.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:provider/provider.dart';

class FriendBlock extends StatelessWidget {
  const FriendBlock(
      {Key? key,
      required this.roomData,
      required this.blockHeight,
      required this.friendData,
      this.isFirst = false})
      : super(key: key);

  final double blockHeight;
  final ChatRoom roomData;
  final Users? friendData;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    NewUserData? user = Provider.of<NewUserData?>(context);
    return Container(
        margin: const EdgeInsets.only(right: 10),
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
              child: Stack(children: [
                Container(
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
                      ? const Icon(
                          Icons.chat_bubble,
                          color: Colors.black,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(roomData.roomPicture),
                                fit: BoxFit.cover),
                          ),
                        ),
                ),
                !isFirst && friendData != null
                    ? buildProfileDeco(friendData!)
                    : Container(),
              ]),
            ),
            Breaker(i: 5),
            buildText.heading5Text(isFirst ? "" : roomData.roomName),
          ],
        ));
  }

  Widget buildProfileDeco(Users friend) {
    int exp = friend.experience;
    int lvl = exp ~/ 100;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      height: blockHeight,
      width: blockHeight * 1.1,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(lvl > 20
              ? "assets/image/L4.png"
              : lvl > 10
                  ? "assets/image/L3.png"
                  : lvl > 5
                      ? "assets/image/L2.png"
                      : "assets/image/L1.png"),
        ),
      ),
    );
  }
}



//  void calculate() {
//     int experience = profile.experience;
//     level = experience ~/ 100;
//     lvl = level.toString();
//     exp = (experience - level! * 100);
//     title = titles[level! ~/ 10 <= 12 ? level! ~/ 10 : 12];
//   }