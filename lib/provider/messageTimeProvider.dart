import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:handsfree/models/messageModel.dart';
import 'package:intl/intl.dart';

class MessageTimeProvider extends ChangeNotifier {
  MessageTimeProvider() {
    prev = null;
    chatRoomId = null;
  }
  Timestamp? prev;
  String? chatRoomId;
  List<Messages> messages = [];

  void updatePrev(Timestamp newPrev) {
    print(
        "update ${prev == null ? "null" : DateFormat("yyyy/MM/dd").add_Hm().format(prev!.toDate())} to ${DateFormat("yyyy/MM/dd").add_Hm().format(newPrev.toDate())}");
    prev = newPrev;
  }

  void updateChatRoomId(String newChatRoomId) {
    print("update $chatRoomId to $newChatRoomId");
    chatRoomId = newChatRoomId;
  }

  Timestamp? get Prev {
    return prev;
  }

  String? get ChatRoomId {
    return chatRoomId;
  }

  void store(List<Messages> messages) {
    this.messages = messages;
  }

  List<Messages> getMessageList() {
    return messages;
  }

  void clearMessageList() {
    messages = [];
  }
}
