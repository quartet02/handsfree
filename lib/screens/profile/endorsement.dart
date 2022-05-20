import "package:flutter/material.dart";
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/models/userProfile.dart';
import 'package:handsfree/services/database.dart';
import 'package:provider/provider.dart';

class EndorseButton extends StatefulWidget {
  const EndorseButton({Key? key, required this.profile, required this.isSelf})
      : super(key: key);

  final Users profile;
  final bool isSelf;

  @override
  State<EndorseButton> createState() => _EndorseButtonState();
}

class _EndorseButtonState extends State<EndorseButton> {
  bool isEndorsed = false;
  @override
  Widget build(BuildContext context) {
    NewUserData user = Provider.of<NewUserData>(context);
    return FutureBuilder<List<String>>(
        future: DatabaseService(uid: user.uid).getFutureEndorsedList(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              (snapshot.connectionState == ConnectionState.done)) {
            List<String> endorsed = snapshot.data!;
            if (endorsed.contains(widget.profile.uid)) {
              isEndorsed = true;
            }
            return Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(isEndorsed || widget.isSelf
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded),
                onPressed: () async {
                  if (!isEndorsed) {
                    if (widget.isSelf) return;
                    await DatabaseService(uid: user.uid)
                        .addEndorsed(widget.profile.uid);
                  } else {
                    await DatabaseService(uid: user.uid)
                        .removeEndorsed(widget.profile.uid);
                  }
                  setState(() {
                    isEndorsed = !isEndorsed;
                  });
                },
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Align(
              alignment: Alignment.topRight,
              child: Tooltip(
                showDuration: const Duration(milliseconds: 2500),
                message: "Updating",
                child: IconButton(
                  icon: Icon(isEndorsed
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded),
                  onPressed: () {
                    // do nothing
                  },
                ),
              ),
            );
          } else {
            return Align(
              alignment: Alignment.topRight,
              child: Tooltip(
                showDuration: const Duration(milliseconds: 2500),
                message: "Can't endorse this user at the moment",
                child: IconButton(
                  icon: const Icon(Icons.warning_amber),
                  onPressed: () {
                    // do nothing
                  },
                ),
              ),
            );
          }
        });
  }
}
