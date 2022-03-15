import 'package:flutter/material.dart';
import 'package:handsfree/models/chatModel.dart';
import 'package:handsfree/models/friendsModel.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/provider/friendsProvider.dart';
import 'package:handsfree/screens/chat/chatContactCard.dart';
import 'package:handsfree/screens/chat/chatList.dart';
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
              const ChatRoomList(),
            ],
          ),
        ),
      ),
    );
  }
}
