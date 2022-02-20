import 'package:flutter/material.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/screens/authenticate/authenticate.dart';
import 'package:handsfree/screens/home/home.dart';
import 'package:handsfree/screens/dictionary/dictionary.dart';
import 'package:handsfree/screens/learn/learn.dart';
import 'package:handsfree/screens/learn/sublevel.dart';
import 'package:provider/provider.dart';

import 'learn/learningpage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser?>(context);

    // return either Home or Authenticate widget
    if (user != null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
