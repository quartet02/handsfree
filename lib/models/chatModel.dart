import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  ChatRoom(
      {required this.createdAt,
      required this.createdBy,
      required this.participants,
      required this.recentMessageText,
      required this.recentSentAt,
      required this.recentSentBy,
      required this.roomId,
      required this.roomName,
      required this.roomPicture,
      required this.type});

  final Timestamp createdAt;
  final String createdBy;
  final List<String> participants;
  final String recentMessageText;
  final Timestamp recentSentAt;
  final String recentSentBy;
  final String roomId;
  String roomName;
  String roomPicture;
  final int type;
}
