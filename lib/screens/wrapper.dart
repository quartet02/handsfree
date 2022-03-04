import 'package:flutter/material.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/screens/authenticate/authenticate.dart';
import 'package:handsfree/screens/dictionary/dictionary.dart';
import 'package:handsfree/screens/home/home.dart';
import 'package:handsfree/screens/learn/congrats.dart';
import 'package:handsfree/screens/learn/learn.dart';
import 'package:handsfree/widgets/loading.dart';
import 'package:handsfree/screens/settings/social.dart';
import 'package:handsfree/screens/settings/terms.dart';
import 'package:handsfree/screens/settings/helpdesk.dart';
import 'package:handsfree/widgets/navBar.dart';
import 'package:provider/provider.dart';
import 'package:handsfree/screens/settings/settings.dart';

import 'profile/acknowledgement.dart';

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
