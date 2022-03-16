import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/services/userPreference.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  // a callback that will be called when application
  // is in background or terminated state
  // and it has to be a top level function
  // (eg: not a class method which requires initialization)
  print('background message ${message.notification!.body}');
}

class FirebaseMessagingService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static _requestingPermission() async {
    // for iOS, macOS and web
    // ask for users permission
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

  static void fcmSubscribe(String topic) {
    _messaging.subscribeToTopic(topic);
    print('Subscribe to $topic');
  }

  static void fcmUnSubscribe(String topic) {
    _messaging.unsubscribeFromTopic(topic);
    print('Unsubscribe to $topic');
  }

  static void handleSubscription(bool val, String topic) {
    val == true ? fcmSubscribe(topic) : fcmUnSubscribe(topic);
  }

  static Future<void> startFcm() async {
    _requestingPermission();
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  static Future<void> updateToken(String uid) async{
    _messaging.getToken().then((value) => DatabaseService(uid: uid).saveToken(value, uid));
  }
}