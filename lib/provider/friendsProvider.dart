import 'package:handsfree/widgets/userPreference.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/friendsModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handsfree/services/database.dart';

class FriendProvider with ChangeNotifier {
  final List<FriendModel> _friends = [];
  List<String> _friendIds = [];
  String _queryText = "";
  late final String _uid;
  late final DatabaseService _dbAccess;
  late final Stream<QuerySnapshot> _friendListSnapshot;
  FriendProvider() {
    // access firebase here
    _uid = UserPreference.get("uniqueId");

    //_dbAccess = DatabaseService(uid: _uid);

    // set listener to update friend list
    // _friendListSnapshot = _dbAccess.getFriendsSnapshot();
    // _friendListSnapshot.listen((event) {
    //   event.docChanges.forEach((element) {
    //     print("hi");
    //   });
    // });
  }

  set query(String text) {
    _queryText = text;
    _updateSuggestion(_queryText);
  }

  set friendIds(List<String> ids) {
    _friendIds = ids;
  }

  void _updateSuggestion(String query) {}
}