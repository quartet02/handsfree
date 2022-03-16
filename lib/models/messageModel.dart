import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  Messages(
      {required this.sentAt,
      required this.sentBy,
      required this.messageText,
      required this.type});

  final Timestamp sentAt;
  final String sentBy;
  final String messageText;
  final int type;
}
