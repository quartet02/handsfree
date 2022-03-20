import 'package:flutter/material.dart';
import 'package:handsfree/models/chatModel.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/screens/social/friendBlock.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/services/userPreference.dart';
import 'package:handsfree/widgets/buildText.dart';

class OnlineFriendList extends StatelessWidget {
  const OnlineFriendList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: DatabaseService(uid: UserPreference.get("uniqueId"))
          .chatsId, // get chatRoom id
      builder: (context, snapshotId) {
        if (snapshotId.hasData &&
            snapshotId.data!.isNotEmpty &&
            snapshotId.connectionState == ConnectionState.active) {
          // snapshotId.data!.forEach(print);
          return StreamBuilder<List<ChatRoom>>(
              stream: DatabaseService(uid: UserPreference.get("uniqueId"))
                  .chats(snapshotId.data!),
              builder: (context, snapshotChat) {
                if (snapshotChat.hasData &&
                    snapshotChat.connectionState == ConnectionState.active) {
                  List<ChatRoom> chatRooms = snapshotChat.data!;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 110,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        shrinkWrap: true,
                        itemCount: chatRooms.length + 1,
                        itemBuilder: (context, index) {
                          if (index > 0) {
                            int i = index - 1;
                            if (chatRooms[i].type == 1) {
                              String id = chatRooms[i].participants[0] ==
                                      UserPreference.get("uniqueId")
                                  ? chatRooms[i].createdBy
                                  : chatRooms[i].participants[0];
                              return StreamBuilder<Users>(
                                  stream: DatabaseService(
                                          uid: UserPreference.get("uniqueId"))
                                      .getSingleFriendById(id),
                                  builder: (context, snapshotUser) {
                                    if (snapshotUser.hasData &&
                                        snapshotUser.connectionState ==
                                            ConnectionState.active) {
                                      Users otherPerson = snapshotUser.data!;
                                      chatRooms[i].roomName = otherPerson.name;
                                      chatRooms[i].roomPicture =
                                          otherPerson.picture;
                                      return FriendBlock(
                                        roomData: chatRooms[i],
                                        blockHeight: 65,
                                      );
                                    } else {
                                      chatRooms[i].roomName = "Not available";
                                      chatRooms[i].roomPicture =
                                          "assets/image/character.png";
                                      return FriendBlock(
                                        roomData: chatRooms[i],
                                        blockHeight: 65,
                                      );
                                    }
                                  });
                            } else {
                              return FriendBlock(
                                roomData: chatRooms[i],
                                blockHeight: 65,
                              );
                            }
                          } else {
                            return FriendBlock(
                                roomData: chatRooms[index],
                                blockHeight: 65,
                                isFirst: true);
                          }
                        }),
                  );
                } else if (snapshotId.connectionState ==
                    ConnectionState.waiting) {
                  return Container();
                } else {
                  return Container(
                    padding: const EdgeInsets.only(top: 100),
                    child: buildText.heading3Text("Chat not found..."),
                  );
                }
              });
        } else if (snapshotId.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          debugPrint(snapshotId.error.toString());
          // on EmptyList
          return Container(
            margin: const EdgeInsets.only(top: 40, bottom: 40),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: buildText.heading3Text("You got no friend..."),
          );
        }
      },
    );
  }
}
