import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/constants.dart';
import 'package:handsfree/widgets/userPreference.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 20),
      color: Colors.black.withOpacity(0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("pressed video call");
            },
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
          ),
          GestureDetector(
            onTap: () async {
              if (input.trim().isNotEmpty) {
                await DatabaseService(uid: UserPreference.get("uniqueId"))
                    .sendMessage(widget.roomId, input);
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
