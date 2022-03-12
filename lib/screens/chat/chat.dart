import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handsfree/models/chatModel.dart';
import 'package:handsfree/models/messageModel.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/screens/chat/chatBar.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/columnList.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/userPreference.dart';

import 'chatBubble.dart';

class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);
  String prev = "";
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    final ChatRoom roomData =
        ModalRoute.of(context)!.settings.arguments as ChatRoom;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/image/orange_heading.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.white,
                  ),
                  Breaker(i: 20, pos: PadPos.right),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("Pressed profile picture");
                        },
                        child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(roomData.roomPicture),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: const Offset(
                                        5, 5), // changes position of shadow
                                  ),
                                ]),
                            child: null),
                      ),
                      Breaker(i: 15, pos: PadPos.right),
                      buildText.textBox(
                          roomData.roomName, 0.5, 22, FontWeight.bold),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 65, 0, 0),
                  color: Colors.black.withOpacity(0),
                  child: StreamBuilder<List<Messages>>(
                    stream: DatabaseService(uid: UserPreference.get("uniqueId"))
                        .messages(roomData.roomId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.active) {
                        List<Messages> messages = snapshot.data!;
                        return ListView.builder(
                            //physics: const BouncingScrollPhysics(),
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return buildChatbubble(messages[index]);
                            });
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              ChatBar(
                roomId: roomData.roomId,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatbubble(Messages message) {
    if (message.sentBy != UserPreference.get("uniqueId") &&
        message.sentBy != widget.prev) {
      widget.prev = message.sentBy;
      return ChatBubble(
          isMe: UserPreference.get("uniqueId") == message.sentBy,
          message: message,
          showProfileIcon: true);
    }
    // self and same sender
    else {
      widget.prev = message.sentBy;
      return ChatBubble(
          isMe: UserPreference.get("uniqueId") == message.sentBy,
          message: message,
          showProfileIcon: false);
    }
  }
}
