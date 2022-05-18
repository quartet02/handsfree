import 'package:camera/camera.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:handsfree/provider/helpdeskProvider.dart';
import 'package:handsfree/provider/lessonCardProvider.dart';
import 'package:handsfree/provider/messageTimeProvider.dart';
import 'package:handsfree/provider/newsFeedProvider.dart';
import 'package:handsfree/provider/subLessonProvider.dart';
import 'package:handsfree/screens/FeedBack/feedback.dart';
import 'package:handsfree/screens/authenticate/authenticate.dart';
import 'package:handsfree/screens/authenticate/levelForm.dart';
import 'package:handsfree/screens/authenticate/signIn.dart';
import 'package:handsfree/screens/authenticate/signUp.dart';
import 'package:handsfree/screens/chat/chat.dart';
import 'package:handsfree/screens/chat/chatHome.dart';
import 'package:handsfree/screens/dictionary/dictionary.dart';
import 'package:handsfree/screens/home/home.dart';
import 'package:handsfree/screens/learn/congrats.dart';
import 'package:handsfree/screens/learn/learn.dart';
import 'package:handsfree/screens/learn/mainLearningPage.dart';
import 'package:handsfree/screens/learn/subLesson.dart';
import 'package:handsfree/screens/learn/timerOut.dart';
import 'package:handsfree/screens/news/news.dart';
import 'package:handsfree/screens/news/news_page.dart';
import 'package:handsfree/screens/profile/profile.dart';
import 'package:handsfree/screens/profile/acknowledgement.dart';
import 'package:handsfree/screens/settings/helpdesk.dart';
import 'package:handsfree/screens/settings/settings.dart';
import 'package:handsfree/screens/social/friendRequest.dart';
import 'package:handsfree/screens/social/searchGlobal.dart';
import 'package:handsfree/screens/social/social.dart';
import 'package:handsfree/screens/settings/terms.dart';
import 'package:handsfree/screens/wrapper.dart';
import 'package:handsfree/services/auth.dart';
import 'package:handsfree/provider/lessonProvider.dart';
import 'package:handsfree/services/mediaAccess.dart';
import 'package:handsfree/services/prepSendImage.dart';
import 'package:handsfree/services/viewPic.dart';
import 'package:handsfree/services/userPreference.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:handsfree/models/newUser.dart';
import 'theme/theme_manager.dart';
import 'theme/theme_constants.dart';

// to store all available camera on device as global variable for easy access
List<CameraDescription> camerasAvailable = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await UserPreference.init();
    camerasAvailable = await availableCameras();
  } on CameraException catch (e) {
    print(e.description);
  }

  runApp(
    MultiProvider(
      child: const MyApp(),
      providers: [
        ChangeNotifierProvider<MessageTimeProvider>(
            create: (_) => MessageTimeProvider()),
        ChangeNotifierProvider<LessonProvider>(create: (_) => LessonProvider()),
        ChangeNotifierProvider<SubLessonProvider>(
            create: (_) => SubLessonProvider()),
        ChangeNotifierProvider<LessonCardProvider>(
            create: (_) => LessonCardProvider()),
        ChangeNotifierProvider<HelpDeskProvider>(
            create: (_) => HelpDeskProvider()),
        ChangeNotifierProvider<NewsFeedProvider>(
            create: (_) => NewsFeedProvider()),
        ChangeNotifierProvider<LessonCardProvider>(
            create: (_) => LessonCardProvider()),
        StreamProvider<NewUserData?>.value(
            value: AuthService().newUserData, initialData: null),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: const Wrapper(),
      routes: {
        "/auth": (context) => const Authenticate(),
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
        "/congratulation": (context) => const Congratulation(),
        // "/translator": (context) => const Translator(),
        "/helpCenter": (context) => const HelpDesk(),
        "/feedback": (context) => const FeedBack(),
        "/news": (context) => const News(),
        "/chatHome": (context) => ChatHome(),
        "/chatHome/chat": (context) => Chat(),
        "/camera": (context) => const CameraScreen(),
        "/prepsend": (context) => const PrepSendImage(),
        "/viewPic": (context) => const ViewPic(),
        "/viewFriendRequest": (context) => const FriendRequest(),
        "/searchGlobalUsers": (context) => const SearchGlobal(),
        "/showNews": (context) => const NewsPage(),
        "/timerOut": (context) => const TimerOut(),
        "/levelForm": (context) => const LevelForm(),
      },
    );
  }
}
