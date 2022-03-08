import 'package:flutter/material.dart';
import 'package:handsfree/models/messageModel.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message, required this.isMe})
      : super(key: key);
  final Messages message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    const radius = const Radius.circular(12);
    final borderRadius = const BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        // if (!isMe)
        //   CircleAvatar(
        //       radius: 16, backgroundImage: NetworkImage(message.urlAvatar)),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 140),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(5, 6),
                  spreadRadius: 1,
                  blurRadius: 8)
            ],
            color: isMe ? Colors.grey[100] : Theme.of(context).accentColor,
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

  Widget buildMessage() => Container(
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.messageText,
              style: TextStyle(color: isMe ? Colors.black : Colors.white),
              textAlign: isMe ? TextAlign.end : TextAlign.start,
            ),
          ],
        ),
      );
}
