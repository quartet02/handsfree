import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/screens/social/friendRequestCard.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/buildText.dart';
import 'package:handsfree/services/userPreference.dart';
import 'package:handsfree/widgets/backButton.dart';

class FriendRequest extends StatefulWidget {
  const FriendRequest({Key? key}) : super(key: key);

  @override
  _FriendRequestState createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  Widget build(BuildContext context) {
    final isVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    // prevent screen rotation and force portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 160, 20, 0),
            child: StreamBuilder<List<String>>(
              stream: DatabaseService(uid: UserPreference.get("uniqueId"))
                  .friendRequestList!,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.data!.isNotEmpty &&
                    snapshot.connectionState == ConnectionState.active) {
                  return StreamBuilder<List<Users>>(
                      stream:
                          DatabaseService(uid: UserPreference.get("uniqueId"))
                              .usersByUIds(snapshot.data!),
                      builder: (context, snapshotUsers) {
                        if (snapshotUsers.hasData &&
                            snapshotUsers.connectionState ==
                                ConnectionState.active) {
                          debugPrint(snapshotUsers.data!.length.toString());
                          List<Users> userDatas = snapshotUsers.data!;
                          return ListView.builder(
                              itemCount: userDatas.length,
                              itemBuilder: (context, index) {
                                return FriendRequestCard(
                                    userData: userDatas[index],
                                    isPromptSendRequest: false);
                              });
                        } else {
                          return Container(
                            child: buildText
                                .heading3Text("No data found for this user"),
                          );
                        }
                      });
                } else {
                  return Container(
                      padding: const EdgeInsets.only(top: 60),
                      child: buildText.heading3Text("No friend request found"));
                }
              },
            ),
          ),
          buildHeading(),
        ],
      ),
    );
  }

  Widget buildHeading() {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
              maxHeight: 172, minWidth: MediaQuery.of(context).size.width),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/orange_heading4.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Button.backButton(context, 30, 9.5),
        Container(
            padding: const EdgeInsets.only(left: 40, bottom: 5, right: 40),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
            alignment: Alignment.topCenter,
            child: buildText.bigTitle("Friend Requests"))
      ],
    );
  }
}
