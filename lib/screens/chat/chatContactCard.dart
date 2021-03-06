import 'package:flutter/material.dart';
import 'package:handsfree/models/chatModel.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';

class ContactCard extends StatelessWidget {
  ContactCard({Key? key, required this.roomData, this.id}) : super(key: key);

  final String? id;
  final ChatRoom roomData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/chatHome/chat", arguments: roomData);
      },
      child: Container(
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
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                Users user = await DatabaseService().getUserById(id!);
                Navigator.pushNamed(context, "/profile", arguments: user);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(roomData.roomPicture),
                  ),
                ),
              ),
            ),
            Breaker(i: 20, pos: PadPos.right),
            Flexible(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText.heading3Text(roomData.roomName),
                    Breaker(i: 3),
                    buildText.heading4Text(roomData.recentMessageText,
                        TextAlign.start, TextOverflow.ellipsis),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
