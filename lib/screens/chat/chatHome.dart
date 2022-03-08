import 'package:flutter/material.dart';
import 'package:handsfree/models/chatModel.dart';
import 'package:handsfree/models/friendsModel.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/provider/friendsProvider.dart';
import 'package:handsfree/screens/chat/chatContactCard.dart';
import 'package:handsfree/screens/dictionary/searchBar.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/userPreference.dart';
import 'package:provider/provider.dart';

class ChatHome extends StatefulWidget {
  ChatHome({Key? key}) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FriendProvider>(
      create: (context) => FriendProvider(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/image/orange_heading.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, bottom: 5, right: 20),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/settings");
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: const DecorationImage(
                          image: AssetImage('assets/image/dummy_cat.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ), // load profile pic from firebase

                  Breaker(i: 15, pos: PadPos.right),
                  buildText.bigTitle("Chats"),
                ]),
              ),
              Breaker(i: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: SearchBar(
                    prompt: "Search for a friend", provider: Providers.friend),
              ),
              StreamBuilder<List<String>>(
                  stream: DatabaseService(uid: UserPreference.get("uniqueId"))
                      .chatsId, // get chatRoom id
                  builder: (context, snapshotId) {
                    if (snapshotId.hasData &&
                        snapshotId.connectionState == ConnectionState.active) {
                      return StreamBuilder<List<ChatRoom>>(
                          stream: DatabaseService(
                                  uid: UserPreference.get("uniqueId"))
                              .chats(snapshotId.data!),
                          builder: (context, snapshotChat) {
                            if (snapshotChat.hasData &&
                                snapshotChat.connectionState ==
                                    ConnectionState.active) {
                              List<ChatRoom> chatRooms = snapshotChat.data!;
                              return SizedBox(
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shrinkWrap: true,
                                    itemCount: chatRooms.length,
                                    itemBuilder: (context, index) {
                                      if (chatRooms[index].type == 1) {
                                        String id = chatRooms[index]
                                                    .participants[0] ==
                                                UserPreference.get("uniqueId")
                                            ? chatRooms[index].createdBy
                                            : chatRooms[index].participants[0];
                                        return StreamBuilder<Users>(
                                            stream: DatabaseService(
                                                    uid: UserPreference.get(
                                                        "uniqueId"))
                                                .getSingleFriendById(id),
                                            builder: (context, snapshotUser) {
                                              if (snapshotUser.hasData &&
                                                  snapshotUser
                                                          .connectionState ==
                                                      ConnectionState.active) {
                                                Users otherPerson =
                                                    snapshotUser.data!;
                                                chatRooms[index].roomName =
                                                    otherPerson.name;
                                                chatRooms[index].roomPicture =
                                                    otherPerson.picture;
                                                return ContactCard(
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
                            } else {
                              return Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 100),
                                  child: buildText
                                      .heading3Text("Chat not found..."),
                                ),
                              );
                            }
                          });
                    } else {
                      // on EmptyList
                      return Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 100),
                          child: buildText.heading3Text("You got no friend..."),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
