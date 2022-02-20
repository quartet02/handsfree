import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:handsfree/screens/authenticate/signIn.dart';
import 'package:handsfree/screens/authenticate/signUp.dart';
import 'package:handsfree/screens/dictionary/dictionary.dart';
import 'package:handsfree/screens/home/chat.dart';
import 'package:handsfree/screens/home/home.dart';
import 'package:handsfree/screens/learn/learn.dart';
import 'package:handsfree/screens/home/profile.dart';
import 'package:handsfree/screens/wrapper.dart';
import 'package:handsfree/services/auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:handsfree/models/newUser.dart';
import 'theme/theme_manager.dart';
import 'theme/theme_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<NewUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeManager.themeMode,
        home: const Wrapper(),
        routes: {
          "/auth/signIn": (context) => const SignIn(),
          "/auth/signUp": (context) => const SignUp(),
          "/home/chat": (context) => const Chat(),
          "/dictionary/dictionary": (context) => const Dictionary(),
          "/home/profile": (context) => const Profile(),
          "/home/home": (context) => const Home(),
          "/learn/learn": (context) => const Learn()
        },
      ),
    );
  }
}
