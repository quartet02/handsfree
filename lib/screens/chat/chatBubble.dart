import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handsfree/models/messageModel.dart';
import 'package:handsfree/widgets/constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.showProfileIcon,
  }) : super(key: key);
  final Messages message;
  final bool isMe;
  final bool showProfileIcon;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(12);
    const borderRadius = BorderRadius.all(radius);

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Row(children: [
            !isMe && showProfileIcon
                ? const CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage("assets/image/character.png"),
                    backgroundColor: Colors.transparent)
                : const CircleAvatar(
                    radius: 16,
                    backgroundImage: null,
                    backgroundColor: Colors.transparent,
                  ),
            Container(
              padding: message.type == 1
                  ? const EdgeInsets.all(13)
                  : const EdgeInsets.all(8),
              margin: const EdgeInsets.all(16)
                  .subtract(const EdgeInsets.only(top: 12)),
              constraints: const BoxConstraints(maxWidth: 220),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: isMe ? kTextShadow : kTextFieldText,
                      offset: const Offset(5, 6),
                      spreadRadius: 1,
                      blurRadius: 8)
                ],
                color: isMe ? Colors.white : kOrangeLight,
                borderRadius: isMe
                    ? borderRadius
                        .subtract(const BorderRadius.only(bottomRight: radius))
                    : borderRadius
                        .subtract(const BorderRadius.only(bottomLeft: radius)),
              ),
              child: buildMessage(context),
            ),
          ])
        ],
      )
    ]);
  }

  Widget buildMessage(BuildContext context) => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          message.type == 1
              ? Text(
                  message.messageText,
                  style: GoogleFonts.montserrat(
                      fontSize: 12, color: isMe ? Colors.black : Colors.white),
                )
              : GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/viewPic",
                        arguments: message.messageText);
                  },
                  child: Image.network(message.messageText),
                ),
        ],
      );
}
