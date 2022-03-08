import 'package:flutter/material.dart';
import 'package:handsfree/models/chatModel.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';

class ContactCard extends StatelessWidget {
  ContactCard({Key? key, required this.roomData}) : super(key: key);

  late final String id;
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
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(5, 6),
                spreadRadius: 1,
                blurRadius: 8)
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                print("pressed profile pic");
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
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildText.heading3Text(roomData.roomName),
                  Breaker(i: 3),
                  buildText.heading4Text(roomData.recentMessageText),
                ]),
          ],
        ),
      ),
    );
  }
}
