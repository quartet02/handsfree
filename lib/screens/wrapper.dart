import 'package:flutter/material.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/screens/authenticate/authenticate.dart';
import 'package:handsfree/screens/home/home.dart';
import 'package:handsfree/services/firebase_messaging_service.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser?>(context);
    FirebaseMessagingService.startFcm();
    // return either Home or Authenticate widget
    if (user != null) {
      return const Authenticate();
    } else {
      FirebaseMessagingService.updateToken(user!.uid!);
      return const Home();
    }
  }
}
