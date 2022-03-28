import 'package:flutter/material.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/services/userPreference.dart';
import 'package:provider/provider.dart';

import '../../widgets/loading.dart';

class ChatBar extends StatefulWidget {
  const ChatBar({Key? key, required this.roomId}) : super(key: key);

  final String roomId;
  @override
  State<ChatBar> createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> {
  final TextEditingController control = TextEditingController();
  String input = "";
  @override
  Widget build(BuildContext context) {
    NewUserData user = Provider.of<NewUserData>(context);

    if (user == null) return const Loading();

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () async {},
            child: Container(
              height: 45,
              width: 45,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(5, 6),
                        spreadRadius: 1,
                        blurRadius: 8)
                  ]),
              child: const Icon(Icons.video_call_rounded,
                  color: kPurpleMid, size: 30),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(5, 6),
                        spreadRadius: 1,
                        blurRadius: 8)
                  ]),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: TextFormField(
                    controller: control,
                    autocorrect: true,
                    enableSuggestions: true,
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: false,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      constraints: BoxConstraints(maxHeight: 100),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: "Aa",
                    ),
                    onChanged: (typed) {
                      setState(() {
                        input = typed;
                      });
                    },
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/camera",
                          arguments: widget.roomId);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 11, 12, 0),
                      child: const Icon(Icons.camera_alt_rounded,
                          color: kPurpleLight),
                    )),
              ]),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (input.trim().isNotEmpty) {
                await DatabaseService(uid: user.uid)
                    .sendMessage(widget.roomId, input, user.name!);
                setState(() {
                  input = "";
                  control.clear();
                });
              }
            },
            child: Container(
              height: 45,
              width: 45,
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(5, 6),
                        spreadRadius: 1,
                        blurRadius: 8)
                  ]),
              child: const Icon(Icons.send, color: kPurpleMid, size: 25),
            ),
          ),
        ],
      ),
    );
  }
}
