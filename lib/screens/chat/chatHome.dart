import 'package:flutter/material.dart';
import 'package:handsfree/provider/friendsProvider.dart';
import 'package:handsfree/screens/chat/chatList.dart';
import 'package:handsfree/screens/dictionary/searchBar.dart';
import 'package:handsfree/widgets/breaker.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:provider/provider.dart';

import '../../widgets/backButton.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 40),
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/image/orange_heading.png'),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Button.backButton(context, 0, 9.5),
              Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 10),
                      child: buildText.bigTitle("Chat")),
                  Breaker(i: 8),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 20,
                        bottom: 10),
                    child: const SearchBar(
                        prompt: "Search for a friend",
                        provider: Providers.friend),
                  ),
                  const ChatRoomList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCreateGroupButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
      child: GestureDetector(
        onTap: () {
          debugPrint("Pressed create group button");
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                  color: kTextShadow,
                  offset: Offset(4, 5),
                  spreadRadius: 1,
                  blurRadius: 6)
            ],
          ),
          child: const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/image/orange_circle.png"),
            child: Icon(Icons.people_alt_rounded, size: 25),
          ),
        ),
      ),
    );
  }
}
