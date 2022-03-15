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
import 'package:handsfree/services/userPreference.dart';

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
      body: Column(children: [
        buildChatHeader(roomData, context),
        buildChatBody(roomData),
        Container(
          child: ChatBar(
            roomId: roomData.roomId,
          ),
        ),
      ]),
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

  Widget buildChatBody(ChatRoom roomData) {
    return Expanded(
      flex: 2,
      child: Container(
        // color: Colors.black.withOpacity(0.2),
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
    );
  }

  Widget buildChatHeader(ChatRoom roomData, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      constraints: BoxConstraints(
          minHeight: 130, maxWidth: MediaQuery.of(context).size.width),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(0, -2),
              blurStyle: BlurStyle.outer,
              spreadRadius: 2,
              blurRadius: 20)
        ],
        image: const DecorationImage(
          image: AssetImage("assets/image/orange_heading3.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        buildText.bigTitle(roomData.roomName),
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.more_vert_rounded,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}
