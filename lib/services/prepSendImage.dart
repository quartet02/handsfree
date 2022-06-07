import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/provider/dictionaryProvider.dart';
import 'package:handsfree/screens/dictionary/translator.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/services/medialoader.dart';
import 'package:handsfree/services/predictImage.dart';
import 'package:handsfree/services/userPreference.dart';
import 'package:handsfree/widgets/loading.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class PrepSendImage extends StatelessWidget {
  const PrepSendImage({Key? key}) : super(key: key);

  // caster: null safety
  T? cast<T>(x) => x is T ? x : null;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUserData?>(context);
    final List<dynamic> imagePath =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    if (user == null) return Loading();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              child: Image.file(File(imagePath[0]!)),
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
                  await File(imagePath[0]!).delete();
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
                  String? chatRoomId = cast<String>(imagePath[1]);
                  print(chatRoomId);
                  // check if null means chat mode, others is ML mode
                  if (chatRoomId != null) {
                    String downloadURL = await uploadFileByPath(
                      imagePath[0]!,
                      "chats_assets",
                      chatRoomId,
                    );
                    await DatabaseService(uid: UserPreference.get("uniqueId"))
                        .sendMessage(chatRoomId, downloadURL, user.name!,
                            isMedia: true);
                  } else {
                    PredictImage();

                    String? result = await PredictImage.classifyImage(
                        cast<XFile>(imagePath[2])!, true);

                    debugPrint("Prediction result in prepSendImage: " +
                        result.toString());

                    List? wordData = await DatabaseService().getWordData();
                    for (Map each in wordData) {
                      if (each['word'] == result) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Translator(
                                each['word'],
                                each['definition'],
                                each['phoneticSymbol'],
                                each['imgUrl']),
                            maintainState: false));
                        break;
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Translator(
                                'Unknown', 'Unknown', 'Unknown', 'Unknown'),
                            maintainState: false));
                      }
                    }
                    await File(imagePath[0]!).delete();

                    return;
                  }

                  Navigator.pop(context);
                  Navigator.pop(context);
                  await File(imagePath[0]!).delete();
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
