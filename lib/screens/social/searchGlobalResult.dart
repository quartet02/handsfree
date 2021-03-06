import 'package:flutter/material.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/screens/social/friendRequestCard.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key, required this.query}) : super(key: key);

  final String query;
  // check is already sent request
  @override
  Widget build(BuildContext context) {
    NewUserData? user = Provider.of<NewUserData?>(context);
    return StreamBuilder<List<Users>>(
      stream: DatabaseService(uid: user!.uid).usersByQuery(query),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.active) {
          List<Users> results = snapshot.data!;
          // remove self
          results.removeWhere((element) => element.uid == user.uid);
          return Consumer<List<String>>(
              builder: (context, toBeExcluded, child) {
            if (toBeExcluded.isNotEmpty) {
              toBeExcluded.forEach(print);
              results.removeWhere((user) => toBeExcluded.contains(user.uid));
            }
            if (results.isEmpty) {
              return Container(
                child: buildText.heading3Text("You have added all of them"),
              );
            }
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return StreamBuilder<List<String>>(
                      stream: DatabaseService(uid: user.uid)
                          .currentFriendRequests(results[index].uid),
                      builder: (context, snapshotCurrent) {
                        if (snapshotCurrent.hasData &&
                            snapshotCurrent.data!.isNotEmpty &&
                            snapshotCurrent.connectionState ==
                                ConnectionState.active) {
                          return FriendRequestCard(
                              userData: results[index],
                              isPromptSendRequest: true,
                              isSent: snapshotCurrent.data!.contains(user.uid));
                        } else {
                          return FriendRequestCard(
                              userData: results[index],
                              isPromptSendRequest: true);
                        }
                      });
                });
          });
        } else {
          return Container(
            child: buildText.heading3Text("No users found"),
          );
        }
      },
    );
  }
}
