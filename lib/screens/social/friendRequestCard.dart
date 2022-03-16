import 'package:flutter/material.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/services/userPreference.dart';

class FriendRequestCard extends StatefulWidget {
  FriendRequestCard(
      {Key? key, required this.userData, this.isPromptSendRequest = false})
      : super(key: key);

  final Users userData;
  final bool isPromptSendRequest;

  @override
  State<FriendRequestCard> createState() => _FriendRequestCardState();
}

class _FriendRequestCardState extends State<FriendRequestCard> {
  bool isSent = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, "/chatHome/chat", arguments: roomData);
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
                        image: AssetImage(widget.userData.picture),
                      ),
                    ),
                  ),
                ),
                Breaker(i: 20, pos: PadPos.right),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText.heading3Text(widget.userData.name),
                      Breaker(i: 3),
                      buildText.heading4Text(widget.userData.title),
                    ]),
              ],
            ),
            widget.isPromptSendRequest ? requestAction() : responseActions(),
          ],
        ),
      ),
    );
  }

  Widget requestAction() {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            !isSent
                ? await DatabaseService(uid: UserPreference.get("uniqueId"))
                    .sendFriendRequest(widget.userData.uid)
                : await DatabaseService(uid: UserPreference.get("uniqueId"))
                    .retrieveFriendRequest(widget.userData.uid);
            setState(() {
              isSent = !isSent;
            });
            print("sent friend request");
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: isSent ? Colors.red : Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
            child: isSent
                ? const Text("Cancel", style: TextStyle(color: Colors.white))
                : const Text(
                    "Connect",
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ),
      ],
    );
  }

  Widget responseActions() {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            await DatabaseService(uid: UserPreference.get("uniqueId"))
                .friendRequestAction(true, widget.userData.uid);
            print("accepted");
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Accept",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await DatabaseService(uid: UserPreference.get("uniqueId"))
                .friendRequestAction(false, widget.userData.uid);
            print("declined");
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Decline",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
