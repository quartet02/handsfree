import 'package:flutter/material.dart';
import 'package:handsfree/models/messageModel.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {Key? key,
      required this.message,
      required this.isMe,
      required this.showProfileIcon})
      : super(key: key);
  final Messages message;
  final bool isMe;
  final bool showProfileIcon;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(12);
    const borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
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
          padding: const EdgeInsets.all(16),
          margin:
              const EdgeInsets.all(16).subtract(const EdgeInsets.only(top: 12)),
          constraints: const BoxConstraints(maxWidth: 140),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(5, 6),
                  spreadRadius: 1,
                  blurRadius: 8)
            ],
            color: isMe
                ? Colors.grey[100]
                : Theme.of(context).colorScheme.secondary,
            borderRadius: isMe
                ? borderRadius
                    .subtract(const BorderRadius.only(bottomRight: radius))
                : borderRadius
                    .subtract(const BorderRadius.only(bottomLeft: radius)),
          ),
          child: buildMessage(),
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.messageText,
            style: TextStyle(color: isMe ? Colors.black : Colors.white),
            textAlign: isMe ? TextAlign.end : TextAlign.start,
          ),
        ],
      );
}
