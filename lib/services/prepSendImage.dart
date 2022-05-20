import 'dart:io';

import 'package:flutter/material.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/services/medialoader.dart';
import 'package:handsfree/services/userPreference.dart';
import 'package:handsfree/widgets/loading.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class PrepSendImage extends StatelessWidget {
  const PrepSendImage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUserData?>(context);
    final List<String> imagePath =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    if (user == null) return Loading();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              child: Image.file(File(imagePath[0])),
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  await File(imagePath[0]).delete();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: const [
                    Icon(
                      Icons.circle,
                      color: Colors.white24,
                      size: 70,
                    ),
                    Icon(
                      Icons.cancel_schedule_send,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  // print(imagePath[0]);
                  // print(imagePath[1]);
                  String downloadURL = await uploadFileByPath(
                    imagePath[0],
                    "chats_assets",
                    imagePath[1],
                  );
                  await DatabaseService(uid: UserPreference.get("uniqueId"))
                      .sendMessage(imagePath[1], downloadURL, user.name!,
                          isMedia: true);
                  Navigator.pop(context);
                  await File(imagePath[0]).delete();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: const [
                    Icon(
                      Icons.circle,
                      color: Colors.white24,
                      size: 70,
                    ),
                    Icon(
                      Icons.send_sharp,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
