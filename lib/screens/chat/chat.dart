import 'package:flutter/material.dart';
import 'package:handsfree/models/chatModel.dart';
import 'package:handsfree/models/messageModel.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/provider/messageTimeProvider.dart';
import 'package:handsfree/screens/chat/chatBar.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:provider/provider.dart';

import '../../widgets/backButton.dart';
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
    Provider.of<MessageTimeProvider>(context, listen: false)
        .updateChatRoomId(roomData.roomId);
    final userProvider = Provider.of<NewUserData?>(context)!;
    return Scaffold(
      body: Column(children: [
        buildHeading(roomData, context, userProvider),
        buildChatBody(roomData, userProvider),
        ChatBar(
          roomId: roomData.roomId,
        ),
      ]),
    );
  }

  Widget buildChatbubble(
      Messages message, ChatRoom roomData, NewUserData userProvider) {
    String id = roomData.participants[0] == userProvider.uid
        ? roomData.createdBy
        : roomData.participants[0];
    if (message.sentBy != userProvider.uid && message.sentBy != widget.prev) {
      widget.prev = message.sentBy;
      return ChatBubble(
          isMe: userProvider.uid == message.sentBy,
          message: message,
          showProfileIcon: true,
          id: id);
    }
    // self and same sender
    else {
      widget.prev = message.sentBy;
      return ChatBubble(
          isMe: userProvider.uid == message.sentBy,
          message: message,
          showProfileIcon: false,
          id: id);
    }
  }

  Widget buildChatBody(ChatRoom roomData, NewUserData userProvider) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: StreamBuilder<List<Messages>>(
          stream:
              DatabaseService(uid: userProvider.uid).messages(roomData.roomId),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.active) {
              List<Messages> messages = snapshot.data!;
              Provider.of<MessageTimeProvider>(context, listen: false)
                  .store(messages);
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return buildChatbubble(
                        messages[index], roomData, userProvider);
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget buildHeading(
      ChatRoom roomData, BuildContext context, NewUserData userProvider) {
    String id = roomData.participants[0] == userProvider.uid
        ? roomData.createdBy
        : roomData.participants[0];
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
        Button.backButton(context, 30, 9.5),
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.topCenter,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            //   child: const Icon(
            //     Icons.arrow_back_ios_new_rounded,
            //     color: Colors.white,
            //   ),
            // ),
            GestureDetector(
              onTap: () async {
                Users user = await DatabaseService().getUserById(id);
                Navigator.pushNamed(context, "/profile", arguments: user);
              },
              child: buildText.bigTitle(roomData.roomName),
            ),

            // GestureDetector(
            //   onTap: () {},
            //   child: const Icon(
            //     Icons.more_vert_rounded,
            //     color: Colors.white,
            //   ),
            // ),
          ]),
        ),
      ],
    );
  }
}
