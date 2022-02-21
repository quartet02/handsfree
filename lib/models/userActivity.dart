import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserActivity with ChangeNotifier {
  String query = "";

  void updateQuery(String q) {
    query = q;
    notifyListeners();
  }

  String getQuery() {
    return query;
  }
}
