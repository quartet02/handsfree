import 'package:flutter/material.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/screens/home/user_tile.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    late final users = Provider.of<List<Users>?>(context) ?? [];

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index){
        return UserTile(user: users == null ? null : users[index]);
      });
  }
}

