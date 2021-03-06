import "package:flutter/material.dart";
import 'package:handsfree/models/chatModel.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/screens/chat/chatContactCard.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:provider/provider.dart';

class ChatRoomList extends StatelessWidget {
  const ChatRoomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewUserData user = Provider.of<NewUserData>(context);
    return StreamBuilder<List<String>>(
        stream: DatabaseService(uid: user.uid).chatsId, // get chatRoom id
        builder: (context, snapshotId) {
          if (snapshotId.hasData &&
              snapshotId.connectionState == ConnectionState.active) {
            return StreamBuilder<List<ChatRoom>>(
                stream: DatabaseService(uid: user.uid).chats(snapshotId.data!),
                builder: (context, snapshotChat) {
                  if (snapshotChat.hasData &&
                      snapshotChat.connectionState == ConnectionState.active) {
                    List<ChatRoom> chatRooms = snapshotChat.data!;
                    return SizedBox(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shrinkWrap: true,
                          itemCount: chatRooms.length,
                          itemBuilder: (context, index) {
                            if (chatRooms[index].type == 1) {
                              String id =
                                  chatRooms[index].participants[0] == user.uid
                                      ? chatRooms[index].createdBy
                                      : chatRooms[index].participants[0];
                              return StreamBuilder<Users>(
                                  stream: DatabaseService(uid: user.uid)
                                      .getSingleFriendById(id),
                                  builder: (context, snapshotUser) {
                                    if (snapshotUser.hasData &&
                                        snapshotUser.connectionState ==
                                            ConnectionState.active) {
                                      Users otherPerson = snapshotUser.data!;
                                      chatRooms[index].roomName =
                                          otherPerson.name;
                                      chatRooms[index].roomPicture =
                                          otherPerson.picture;
                                      return ContactCard(
                                        id: otherPerson.uid,
                                        roomData: chatRooms[index],
                                      );
                                    } else {
                                      chatRooms[index].roomName =
                                          "Not available";
                                      chatRooms[index].roomPicture =
                                          "assets/image/character.png";
                                      return ContactCard(
                                          roomData: chatRooms[index]);
                                    }
                                  });
                            } else {
                              return ContactCard(
                                roomData: chatRooms[index],
                              );
                            }
                          }),
                    );
                  } else if (snapshotId.connectionState ==
                      ConnectionState.waiting) {
                    return Container();
                  } else {
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 50, bottom: 50),
                        child: buildText.heading3Text("Chat not found..."),
                      ),
                    );
                  }
                });
          } else if (snapshotId.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            // on EmptyList
            return Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: buildText.heading3Text("You got no friend..."),
              ),
            );
          }
        });
  }
}
