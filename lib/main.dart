import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:handsfree/provider/helpdeskProvider.dart';
import 'package:handsfree/provider/subLessonProvider.dart';
import 'package:handsfree/screens/FeedBack/feedback.dart';
import 'package:handsfree/screens/authenticate/signIn.dart';
import 'package:handsfree/screens/authenticate/signUp.dart';
import 'package:handsfree/screens/dictionary/dictionary.dart';
import 'package:handsfree/screens/home/home.dart';
import 'package:handsfree/screens/learn/learn.dart';
import 'package:handsfree/screens/learn/mainLearningPage.dart';
import 'package:handsfree/screens/learn/subLesson.dart';
import 'package:handsfree/screens/profile/profile.dart';
import 'package:handsfree/screens/profile/acknowledgement.dart';
import 'package:handsfree/screens/settings/helpdesk.dart';
import 'package:handsfree/screens/settings/settings.dart';
import 'package:handsfree/screens/settings/social.dart';
import 'package:handsfree/screens/settings/terms.dart';
import 'package:handsfree/screens/wrapper.dart';
import 'package:handsfree/services/auth.dart';
import 'package:handsfree/provider/lessonProvider.dart';
import 'package:handsfree/widgets/userPreference.dart';
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
  await UserPreference.init();

  runApp(
    MultiProvider(
      child: const MyApp(),
      providers: [
        ChangeNotifierProvider<LessonProvider>(create: (_) => LessonProvider()),
        ChangeNotifierProvider<SubLessonProvider>(
            create: (_) => SubLessonProvider()),
      ],
    ),
  );
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
          "/social": (context) => const Social(),
          "/dictionary": (context) => const Dictionary(),
          "/profile": (context) => const Profile(),
          "/home": (context) => const Home(),
          "/learn": (context) => const Learn(),
          "/sublevel": (context) => const SubLevel(),
          "/settings": (context) => const Settings(),
          "/acknowledgement": (context) => const Acknowledgement(),
          "/terms": (context) => Terms(),
          "/mainLearningPage": (context) => const MainLearningPage(),
          "/helpCenter": (context) => const HelpDesk(),
          "/feedback": (context) => const FeedBack(),
        },
      ),
    );
  }
}
