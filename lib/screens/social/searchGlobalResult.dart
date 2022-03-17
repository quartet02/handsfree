import 'package:flutter/material.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/screens/social/friendRequestCard.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/services/userPreference.dart';
import 'package:handsfree/widgets/buildText.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key, required this.query}) : super(key: key);

  final String query;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Users>>(
      stream: DatabaseService(uid: UserPreference.get("uniqueId"))
          .usersByQuery(query),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.active) {
          List<Users> results = snapshot.data!;
          results.removeWhere(
              (element) => element.uid == UserPreference.get("uniqueId"));
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: results.length,
            itemBuilder: (context, index) {
              return FriendRequestCard(
                  userData: results[index], isPromptSendRequest: true);
            },
          );
        } else {
          return Container(
            child: buildText.heading3Text("No users found"),
          );
        }
      },
    );
  }
}
