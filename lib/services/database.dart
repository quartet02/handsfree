import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handsfree/models/communityModel.dart';
import 'package:handsfree/models/newsFeedModel.dart';
import 'package:handsfree/models/chatModel.dart';
import 'package:handsfree/models/lessonCardModel.dart';
import 'package:handsfree/models/lessonModel.dart';
import 'package:handsfree/models/messageModel.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/models/wordModel.dart';
import 'package:handsfree/services/auth.dart';
import 'package:handsfree/services/userPreference.dart';
import 'package:rxdart/rxdart.dart';
import '../models/userProfile.dart';
import 'package:flamingo/flamingo.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference chatRoomCollection =
      FirebaseFirestore.instance.collection('chatRoom');
  final CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('message');
  final CollectionReference lessonsCollection =
      FirebaseFirestore.instance.collection('lessons');
  final CollectionReference contributorCollection =
      FirebaseFirestore.instance.collection('contributor');
  final CollectionReference newsCollection =
      FirebaseFirestore.instance.collection('news');
  final CollectionReference leaderboardCollection =
      FirebaseFirestore.instance.collection('leaderboard');
  final CollectionReference feedbackCollection =
      FirebaseFirestore.instance.collection('feedback');
  final CollectionReference devicesCollection =
      FirebaseFirestore.instance.collection('devices');

  ///From User Collection
  Future updateSingleData(String selector, String value) async {
    if (selector == 'name') {
      return await userCollection.doc(uid).update({
        'name': value,
      });
    } else if (selector == 'username') {
      return await userCollection.doc(uid).update({
        'username': value,
      });
    } else if (selector == 'password') {
      AuthService().changePassword(value);
      return;
    } else if (selector == 'title') {
      return await userCollection.doc(uid).update({
        'title': value,
      });
    } else if (selector == 'none') {
      return;
    } else {
      print('Return Nothing');
      return;
    }
  }

  Future updateIsCompletedSubLesson(
      String syllabus, String lesson, String subLessonId) {
    return userCollection
        .doc(uid)
        .collection('lessons')
        .doc(syllabus)
        .collection(lesson)
        .doc(subLessonId)
        .update({
      'isCompleted': true,
    });
  }

  Future updateIsCompletedLesson(String syllabus, String lesson) {
    return userCollection
        .doc(uid)
        .collection('lessons')
        .doc(syllabus)
        .collection('lessonsOverview')
        .doc(lesson)
        .update({
      'isCompleted': true,
    });
  }

  Future updateIsCompletedSyllabus(String syllabus) {
    return userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Overview')
        .collection('Overview')
        .doc(syllabus)
        .update({
      'isCompleted': true,
    });
  }

  List<LessonModel>? _syllabusList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return LessonModel(
          lessonDesc: doc['lessonDesc'],
          lessonId: doc['lessonId'],
          lessonImage: doc['lessonImage'],
          lessonName: doc['lessonName'],
          isCompleted: doc['isCompleted']);
    }).toList();
  }

  Stream<List<LessonModel>?> getSyllabus(String syllabus) {
    return userCollection
        .doc(uid)
        .collection('lessons')
        .doc(syllabus)
        .collection('lessonsOverview')
        .snapshots()
        .map(_syllabusList);
  }

  Stream<List<LessonModel>?> getSyllabusOverview() {
    return userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Overview')
        .collection('Overview')
        .snapshots()
        .map((_syllabusList));
  }

  List<LessonCardModel> _lessonCardList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return LessonCardModel(
        lessonCardDesc: doc['lessonCardDesc'],
        lessonCardId: doc['lessonCardId'],
        lessonCardImage: doc['lessonCardImage'],
        lessonCardTitle: doc['lessonCardTitle'],
        lessonId: doc['lessonId'],
        isCompleted: doc['isCompleted'],
      );
    }).toList();
  }

  Stream<List<LessonCardModel>> getSelectedLessonCard(
      String syllabus, String lesson) {
    return userCollection
        .doc(uid)
        .collection('lessons')
        .doc(syllabus)
        .collection(lesson)
        .snapshots()
        .map(_lessonCardList);
  }

  //individual user login activity
  NewUserActivityLog _userActivityLog(DocumentSnapshot snapshot) {
    return NewUserActivityLog(
      lastLoginIn: snapshot['lastLoginIn'],
      activity: List.from(snapshot['login']),
    );
  }

  Stream<NewUserActivityLog> get activity {
    return userCollection
        .doc(uid)
        .collection('log')
        .doc('Activity')
        .snapshots()
        .map(_userActivityLog);
  }

  Future<dynamic> getActivityLog(String selector) async {
    if (selector == "List") {
      final activityData =
          await userCollection.doc(uid).collection('log').doc('Activity').get();
      var data = activityData['login'];
      return data;
    }

    if (selector == "Time") {
      final activityData =
          await userCollection.doc(uid).collection('log').doc('Activity').get();
      var data = activityData['lastLoginIn'];
      return data;
    }
    return;
  }

  Future updateActivityLog(List activityLog, Timestamp time) {
    DateTime now = DateTime.now();
    DateTime last = DateTime.parse(time.toDate().toString());
    double days = daysBetween(last, now);

    ///refresh on sunday
    ///login on saturday, skip sunday, login on monday
    ///duration more than 7 days
    ///on same date(Friday and Friday, but different week)
    activityLog[now.weekday < 7 ? now.weekday : 0] = true;
    if (now.weekday == 7 ||
        (now.weekday < last.weekday && last.weekday != 7) ||
        days >= 7 ||
        (now.weekday == last.weekday && days >= 1)) {
      activityLog = [false, false, false, false, false, false, false];
    }

    activityLog[now.weekday < 7 ? now.weekday : 0] = true;
    return userCollection.doc(uid).collection('log').doc('Activity').update({
      'lastLoginIn': Timestamp.now(),
      'login': activityLog,
    });
  }

  //NewUserData from snapshot aka single data of specific user
  NewUserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return NewUserData(
      uid: uid,
      name: snapshot['name'],
      experience: snapshot['experience'],
      phoneNumber: snapshot['phoneNumber'],
      picture: snapshot['picture'],
      title: snapshot['title'],
      username: snapshot['username'],
    );
  }

  Future<DocumentSnapshot<Object?>>? getNewUserDataSnapshot(User? user) {
    if (user == null) return null;
    return userCollection.doc(user.uid).get();
  }

  //new user register
  Future updateUserData(int experience, String name, String phoneNumber,
      String picture, String title, String username) async {
    // init user doc
    await userCollection.doc(uid).set({
      'experience': experience,
      'phoneNumber': phoneNumber,
      'picture': picture,
      'title': title,
      'username': username,
      'name': name,
      'uid': uid,
      'groups': FieldValue.arrayUnion([]),
    }).then((_) {
      print("Success!");
    });
    // init friend list
    await userCollection
        .doc(uid)
        .collection("friends")
        .doc("friends")
        .set({"list": FieldValue.arrayUnion([])});
  }

  Future<void> createChatRoom(List<String> friendIds, String? name, int type,
      String createrName) async {
    await chatRoomCollection.add({
      'createdAt': Timestamp.now(),
      'createdBy': uid,
      'participants': FieldValue.arrayUnion(friendIds),
      'recentMsg': {
        'messageText': "",
        'sentAt': "",
        'sentBy': "",
      },
      'roomId': "",
      'roomName': name ?? "",
      'roomPicture': "",
      'type': type,
    }).then((doc) async {
      // print(doc.id);
      await doc.update({"roomId": doc.id});
      friendIds.add(uid!);
      friendIds.forEach((id) async {
        print(id);
        List<String> prev = await userCollection
            .doc(id)
            .get()
            .then((doc) => List<String>.from(doc["groups"]));
        prev.add(doc.id);
        await userCollection
            .doc(id)
            .update({'groups': FieldValue.arrayUnion(prev)});
      });

      await sendMessage(
          doc.id,
          type != 1
              ? "I have opened a group for us. Let us hang out now!"
              : "I have accepted your friend request. Let us chat now!",
          createrName);
    });
  }

  Future<void> addToFriendList(String otherSideId) async {
    // self side
    List<String> prev1 = await userCollection
        .doc(uid)
        .collection("friends")
        .doc("friends")
        .get()
        .then((doc) => List<String>.from(doc["list"]));
    prev1.add(otherSideId);
    await userCollection
        .doc(uid)
        .collection("friends")
        .doc("friends")
        .set({"list": FieldValue.arrayUnion(prev1)});
    // other side
    List<String> prev2 = await userCollection
        .doc(otherSideId)
        .collection("friends")
        .doc("friends")
        .get()
        .then((doc) => List<String>.from(doc["list"]));

    prev2.add(uid!);
    await userCollection
        .doc(otherSideId)
        .collection("friends")
        .doc("friends")
        .set({"list": FieldValue.arrayUnion(prev2)});
  }

  Future<void> removeFriend(String otherSideId) async {
    await userCollection.doc(uid).collection("friends").doc("friends").set({
      "list": FieldValue.arrayRemove([otherSideId])
    });
    // chat room created by otherSideId and current user as participants
    var q1 = await chatRoomCollection
        .where("createdBy", isEqualTo: otherSideId)
        .where("participants", arrayContains: uid)
        .where("type", isEqualTo: 1)
        .get();
    // chat room contains otherSideId and current user as the room creator
    var q2 = await chatRoomCollection
        .where(
          "participants",
          arrayContains: otherSideId,
        )
        .where("createdBy", isEqualTo: uid)
        .where("type", isEqualTo: 1)
        .get();
    if (q1.size == 0) {
      q2.docs.map((doc) {
        String roomId = doc['roomId'];
        chatRoomCollection.doc(roomId).delete();
      });
    } else {
      q1.docs.map((doc) {
        String roomId = doc['roomId'];
        chatRoomCollection.doc(roomId).delete();
      });
    }
  }

  Future<void> sendFriendRequest(String otherSideId) async {
    Map<String, dynamic> data = {
      'receiverUid': otherSideId,
      'name': 'senderName',
    };

    connectFunction('friendRequest', data);

    print("sent friend request");
    await userCollection
        .doc(otherSideId)
        .collection("friend_requests")
        .doc(uid)
        .set({"uid": uid});
  }

  Future<int> connectFunction(func, Map<String, dynamic> data) async {
    // notification
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(func,
        options: HttpsCallableOptions(
          timeout: const Duration(seconds: 5),
        ));
    try {
      final result = await callable.call(data);
      print('Notification sent successfully');
      return 1;
    } catch (e) {
      print('error sending message');
      return -1;
    }
  }

  Future<void> retrieveFriendRequest(String otherSideId) async {
    print("retrieve friend request");
    await userCollection
        .doc(otherSideId)
        .collection("friend_requests")
        .doc(uid)
        .delete();
  }

  Future<int> friendRequestAction(
      bool isAccepted, String otherSideId, String createrName) async {
    try {
      await userCollection
          .doc(uid)
          .collection("friend_requests")
          .doc(otherSideId)
          .delete();
      print("successfully cleaned");
      if (isAccepted) {
        await createChatRoom([otherSideId], null, 1, createrName)
            .onError((error, stackTrace) => print(error.toString()));
        await addToFriendList(otherSideId)
            .onError((error, stackTrace) => print(error.toString()));
        print("successfully created and added");
      }
      return isAccepted ? 201 : 200;
    } catch (e) {
      return 400;
    }
  }

  Stream<List<String>>? get friendRequestList {
    return userCollection
        .doc(uid)
        .collection("friend_requests")
        .snapshots()
        .map(_friendRequestListFromSnapshot);
  }

  List<String> _friendRequestListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return doc["uid"] as String;
    }).toList();
  }

  Future<void> updateExperience() async {
    userCollection.doc(uid).update({
      'experience': FieldValue.increment(15),
    });
  }

  Future<void> buildUserLesson() async {
    ///Syllabus 1 Lesson 1
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 1')
        .doc('a')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "A",
      "lessonCardDesc": "Alphabet A",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'a',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 1')
        .doc('b')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "B",
      "lessonCardDesc": "Alphabet B",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'b',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 1')
        .doc('c')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "C",
      "lessonCardDesc": "Alphabet C",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'c',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 1')
        .doc('d')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "D",
      "lessonCardDesc": "Alphabet D",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'd',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 1')
        .doc('e')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "E",
      "lessonCardDesc": "Alphabet E",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'e',
      "isCompleted": false,
    });

    ///Syllabus 1 Lesson 2
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 2')
        .doc('f')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "F",
      "lessonCardDesc": "Alphabet F",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'f',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 2')
        .doc('g')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "G",
      "lessonCardDesc": "Alphabet G",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'g',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 2')
        .doc('h')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "H",
      "lessonCardDesc": "Alphabet H",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'h',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 2')
        .doc('i')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "I",
      "lessonCardDesc": "Alphabet I",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'i',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 2')
        .doc('j')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "J",
      "lessonCardDesc": "Alphabet J",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'j',
      "isCompleted": false,
    });

    ///Syllabus 1 Lesson 3
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 3')
        .doc('k')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "K",
      "lessonCardDesc": "Alphabet K",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'k',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 3')
        .doc('l')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "L",
      "lessonCardDesc": "Alphabet L",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'l',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 3')
        .doc('m')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "M",
      "lessonCardDesc": "Alphabet M",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'm',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 3')
        .doc('n')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "N",
      "lessonCardDesc": "Alphabet n",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'n',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 3')
        .doc('o')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "O",
      "lessonCardDesc": "Alphabet O",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'o',
      "isCompleted": false,
    });

    ///Syllabus 1 Lesson 4
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 4')
        .doc('p')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "P",
      "lessonCardDesc": "Alphabet P",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'p',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 4')
        .doc('q')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "Q",
      "lessonCardDesc": "Alphabet Q",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'q',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 4')
        .doc('r')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "R",
      "lessonCardDesc": "Alphabet R",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'r',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 4')
        .doc('s')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "S",
      "lessonCardDesc": "Alphabet S",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 's',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 4')
        .doc('t')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "T",
      "lessonCardDesc": "Alphabet T",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 't',
      "isCompleted": false,
    });

    ///Syllabus 1 Lesson 5
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 5')
        .doc('u')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "U",
      "lessonCardDesc": "Alphabet U",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'u',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 5')
        .doc('v')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "V",
      "lessonCardDesc": "Alphabet V",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'v',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 5')
        .doc('w')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "W",
      "lessonCardDesc": "Alphabet W",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'w',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 5')
        .doc('x')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "X",
      "lessonCardDesc": "Alphabet X",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'x',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 5')
        .doc('y')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Y",
      "lessonCardDesc": "Alphabet Y",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'y',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Lesson 5')
        .doc('z')
        .set({
      "lessonCardId": 006,
      "lessonCardTitle": "Z",
      "lessonCardDesc": "Alphabet Z",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'z',
      "isCompleted": false,
    });

    ///To Syllabus 1

    ///Syllabus 2 Lesson 1
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 1')
        .doc('hello')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "Hello",
      "lessonCardDesc": "Sign of 'Hello'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'hello',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 1')
        .doc('hey')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "Hey",
      "lessonCardDesc": "Sign of 'Hey'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'hey',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 1')
        .doc('whatsup')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "What's up",
      "lessonCardDesc": "Sign of 'What's up'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'whatsup',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 1')
        .doc('my')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "My",
      "lessonCardDesc": "Sign of 'My'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'my',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 1')
        .doc('name')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Name",
      "lessonCardDesc": "Sign of 'Name'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'name',
      "isCompleted": false,
    });

    ///Syllabus 2 Lesson 2
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 2')
        .doc('nice')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "Nice",
      "lessonCardDesc": "Sign of 'Nice'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'nice',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 2')
        .doc('meet')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "Meet",
      "lessonCardDesc": "Sign of 'Meet'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'meet',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 2')
        .doc('i')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "I",
      "lessonCardDesc": "Sign of 'I', which people use to mention themselves",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'i',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 2')
        .doc('learn')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "Learn",
      "lessonCardDesc": "Sign of 'Learn'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'learn',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 2')
        .doc('sign')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Sign",
      "lessonCardDesc": "Sign of 'Sign'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'sign',
      "isCompleted": false,
    });

    ///Syllabus 2 Lesson 3
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 3')
        .doc('your')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "Your",
      "lessonCardDesc": "Sign of 'Your'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'your',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 3')
        .doc('what')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "What",
      "lessonCardDesc":
          "Sign of 'What', this sign is usually shown at the last of the signing sentence.",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'what',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 3')
        .doc('you')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "You",
      "lessonCardDesc": "Sign of 'You'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'you',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 3')
        .doc('from')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "From",
      "lessonCardDesc": "Sign of 'From'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'from',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 3')
        .doc('where')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Where",
      "lessonCardDesc":
          "Sign of 'Where', this sign is usually shown at the last of the signing sentence.",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'where',
      "isCompleted": false,
    });

    ///Syllabus 2 Lesson 4
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 4')
        .doc('imfine')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "I'm fine",
      "lessonCardDesc": "Sign of 'I'm fine'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'imfine',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 4')
        .doc('please')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "Please",
      "lessonCardDesc": "Sign of 'Please'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'please',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 4')
        .doc('tq')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "Thank you",
      "lessonCardDesc": "Sign of 'Thank you'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'tq',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 4')
        .doc('xcuseme')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "Excuse me",
      "lessonCardDesc": "Sign of 'Excuse me'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'xcuseme',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 4')
        .doc('favourite')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Favourite",
      "lessonCardDesc": "Sign of 'Favourite'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'favourite',
      "isCompleted": false,
    });

    ///Syllabus 2 Lesson 5
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 5')
        .doc('place')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "Place",
      "lessonCardDesc": "Sign of 'Place'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'place',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 5')
        .doc('movie')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "Movie",
      "lessonCardDesc": "Sign of 'Movie'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'movie',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 5')
        .doc('whatdo')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "What do",
      "lessonCardDesc":
          "Sign of 'What do', this sign is usually shown at the last of signing sentence.",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'whatdo',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 5')
        .doc('word')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "Work",
      "lessonCardDesc": "Sign of 'Work'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'word',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 5')
        .doc('time')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Time",
      "lessonCardDesc": "Sign of 'Time'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'time',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 5')
        .doc('bathroom')
        .set({
      "lessonCardId": 006,
      "lessonCardTitle": "Bathroom",
      "lessonCardDesc": "Sign of 'Bathroom'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'bathroom',
      "isCompleted": false,
    });

    ///Syllabus 2 Lesson 6
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 6')
        .doc('how')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "How",
      "lessonCardDesc": "Sign of 'How'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'how',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 6')
        .doc('meaning')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "Meaning",
      "lessonCardDesc":
          "Sign of 'Meaning', which is used to ask the meaning the sign shown.",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'meaning',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 6')
        .doc('goodbye')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "Goodbye",
      "lessonCardDesc": "Sign of 'Goodbye'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'goodbye',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 6')
        .doc('culater')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "See you later",
      "lessonCardDesc": "Sign of 'See you later'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'culater',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 6')
        .doc('takecare')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Take care",
      "lessonCardDesc": "Sign of 'Take care'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'takecare',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Lesson 6')
        .doc('howareyou')
        .set({
      "lessonCardId": 006,
      "lessonCardTitle": "How are you",
      "lessonCardDesc": "Sign of 'How are you'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'howareyou',
      "isCompleted": false,
    });

    ///To Syllabus 2

    ///Syllabus 3 Lesson 1
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 1')
        .doc('a')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "A",
      "lessonCardDesc": "Alphabet A",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'a',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 1')
        .doc('b')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "B",
      "lessonCardDesc": "Alphabet B",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'b',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 1')
        .doc('c')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "C",
      "lessonCardDesc": "Alphabet C",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'c',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 1')
        .doc('d')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "D",
      "lessonCardDesc": "Alphabet D",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'd',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 1')
        .doc('e')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "E",
      "lessonCardDesc": "Alphabet E",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'e',
      "isCompleted": false,
    });

    ///Syllabus 3 Lesson 2
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 2')
        .doc('f')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "F",
      "lessonCardDesc": "Alphabet F",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'f',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 2')
        .doc('g')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "G",
      "lessonCardDesc": "Alphabet G",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'g',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 2')
        .doc('h')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "H",
      "lessonCardDesc": "Alphabet H",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'h',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 2')
        .doc('i')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "I",
      "lessonCardDesc": "Alphabet I",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'i',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 2')
        .doc('j')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "J",
      "lessonCardDesc": "Alphabet J",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'j',
      "isCompleted": false,
    });

    ///Syllabus 3 Lesson 3
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 3')
        .doc('k')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "K",
      "lessonCardDesc": "Alphabet K",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'k',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 3')
        .doc('l')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "L",
      "lessonCardDesc": "Alphabet L",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'l',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 3')
        .doc('m')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "M",
      "lessonCardDesc": "Alphabet M",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'm',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 3')
        .doc('n')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "N",
      "lessonCardDesc": "Alphabet n",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'n',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 3')
        .doc('o')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "O",
      "lessonCardDesc": "Alphabet O",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'o',
      "isCompleted": false,
    });

    ///Syllabus 3 Lesson 4
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 4')
        .doc('p')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "P",
      "lessonCardDesc": "Alphabet P",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'p',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 4')
        .doc('q')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "Q",
      "lessonCardDesc": "Alphabet Q",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'q',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 4')
        .doc('r')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "R",
      "lessonCardDesc": "Alphabet R",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'r',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 4')
        .doc('s')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "S",
      "lessonCardDesc": "Alphabet S",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 's',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 4')
        .doc('t')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "T",
      "lessonCardDesc": "Alphabet T",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 't',
      "isCompleted": false,
    });

    ///Syllabus 3 Lesson 5
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 5')
        .doc('u')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "U",
      "lessonCardDesc": "Alphabet U",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'u',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 5')
        .doc('v')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "V",
      "lessonCardDesc": "Alphabet V",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'v',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 5')
        .doc('w')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "W",
      "lessonCardDesc": "Alphabet W",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'w',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 5')
        .doc('x')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "X",
      "lessonCardDesc": "Alphabet X",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'x',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 5')
        .doc('y')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Y",
      "lessonCardDesc": "Alphabet Y",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'y',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('Lesson 5')
        .doc('z')
        .set({
      "lessonCardId": 006,
      "lessonCardTitle": "Z",
      "lessonCardDesc": "Alphabet Z",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'z',
      "isCompleted": false,
    });

    ///To Syllabus 3

    ///Syllabus 4 Lesson 1
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 1')
        .doc('hello')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "Hello",
      "lessonCardDesc": "Sign of 'Hello'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'hello',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 1')
        .doc('hey')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "Hey",
      "lessonCardDesc": "Sign of 'Hey'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'hey',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 1')
        .doc('whatsup')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "What's up",
      "lessonCardDesc": "Sign of 'What's up'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'whatsup',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 1')
        .doc('my')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "My",
      "lessonCardDesc": "Sign of 'My'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'my',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 1')
        .doc('name')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Name",
      "lessonCardDesc": "Sign of 'Name'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'name',
      "isCompleted": false,
    });

    ///Syllabus 4 Lesson 2
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 2')
        .doc('nice')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "Nice",
      "lessonCardDesc": "Sign of 'Nice'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'nice',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 2')
        .doc('meet')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "Meet",
      "lessonCardDesc": "Sign of 'Meet'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'meet',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 2')
        .doc('i')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "I",
      "lessonCardDesc": "Sign of 'I', which people use to mention themselves",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'i',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 2')
        .doc('learn')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "Learn",
      "lessonCardDesc": "Sign of 'Learn'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'learn',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 2')
        .doc('sign')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Sign",
      "lessonCardDesc": "Sign of 'Sign'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'sign',
      "isCompleted": false,
    });

    ///Syllabus 4 Lesson 3
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 3')
        .doc('your')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "Your",
      "lessonCardDesc": "Sign of 'Your'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'your',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 3')
        .doc('what')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "What",
      "lessonCardDesc":
          "Sign of 'What', this sign is usually shown at the last of the signing sentence.",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'what',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 3')
        .doc('you')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "You",
      "lessonCardDesc": "Sign of 'You'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'you',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 3')
        .doc('from')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "From",
      "lessonCardDesc": "Sign of 'From'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'from',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 3')
        .doc('where')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Where",
      "lessonCardDesc":
          "Sign of 'Where', this sign is usually shown at the last of the signing sentence.",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'where',
      "isCompleted": false,
    });

    ///Syllabus 4 Lesson 4
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 4')
        .doc('imfine')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "I'm fine",
      "lessonCardDesc": "Sign of 'I'm fine'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'imfine',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 4')
        .doc('please')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "Please",
      "lessonCardDesc": "Sign of 'Please'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'please',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 4')
        .doc('tq')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "Thank you",
      "lessonCardDesc": "Sign of 'Thank you'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'tq',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 4')
        .doc('xcuseme')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "Excuse me",
      "lessonCardDesc": "Sign of 'Excuse me'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'xcuseme',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 4')
        .doc('favourite')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Favourite",
      "lessonCardDesc": "Sign of 'Favourite'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'favourite',
      "isCompleted": false,
    });

    ///Syllabus 2 Lesson 5
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 5')
        .doc('place')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "Place",
      "lessonCardDesc": "Sign of 'Place'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'place',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 5')
        .doc('movie')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "Movie",
      "lessonCardDesc": "Sign of 'Movie'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'movie',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 5')
        .doc('whatdo')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "What do",
      "lessonCardDesc":
          "Sign of 'What do', this sign is usually shown at the last of signing sentence.",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'whatdo',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 5')
        .doc('word')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "Work",
      "lessonCardDesc": "Sign of 'Work'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'word',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 5')
        .doc('time')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Time",
      "lessonCardDesc": "Sign of 'Time'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'time',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 5')
        .doc('bathroom')
        .set({
      "lessonCardId": 006,
      "lessonCardTitle": "Bathroom",
      "lessonCardDesc": "Sign of 'Bathroom'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'bathroom',
      "isCompleted": false,
    });

    ///Syllabus 4 Lesson 6
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 6')
        .doc('how')
        .set({
      "lessonCardId": 001,
      "lessonCardTitle": "How",
      "lessonCardDesc": "Sign of 'How'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'how',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 6')
        .doc('meaning')
        .set({
      "lessonCardId": 002,
      "lessonCardTitle": "Meaning",
      "lessonCardDesc":
          "Sign of 'Meaning', which is used to ask the meaning the sign shown.",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'meaning',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 6')
        .doc('goodbye')
        .set({
      "lessonCardId": 003,
      "lessonCardTitle": "Goodbye",
      "lessonCardDesc": "Sign of 'Goodbye'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'goodbye',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 6')
        .doc('culater')
        .set({
      "lessonCardId": 004,
      "lessonCardTitle": "See you later",
      "lessonCardDesc": "Sign of 'See you later'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'culater',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 6')
        .doc('takecare')
        .set({
      "lessonCardId": 005,
      "lessonCardTitle": "Take care",
      "lessonCardDesc": "Sign of 'Take care'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'takecare',
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('Lesson 6')
        .doc('howareyou')
        .set({
      "lessonCardId": 006,
      "lessonCardTitle": "How are you",
      "lessonCardDesc": "Sign of 'How are you'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'howareyou',
      "isCompleted": false,
    });

    ///To Syllabus 4

    ///From Syllabus 1 Lesson Overview
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('lessonsOverview')
        .doc('Lesson 1')
        .set({
      "lessonId": 001,
      "lessonName": "Lesson 1",
      "lessonDesc": "Alphabet A-E",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('lessonsOverview')
        .doc('Lesson 2')
        .set({
      "lessonId": 002,
      "lessonName": "Lesson 2",
      "lessonDesc": "Alphabet F-J",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('lessonsOverview')
        .doc('Lesson 3')
        .set({
      "lessonId": 003,
      "lessonName": "Lesson 3",
      "lessonDesc": "Alphabet K-O",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('lessonsOverview')
        .doc('Lesson 4')
        .set({
      "lessonId": 004,
      "lessonName": "Lesson 4",
      "lessonDesc": "Alphabet P-T",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('lessonsOverview')
        .doc('Lesson 5')
        .set({
      "lessonId": 005,
      "lessonName": "Lesson 5",
      "lessonDesc": "Alphabet U-Z",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    ///To Syllabus 1 Lesson Overview

    ///From Syllabus 2 Lesson Overview
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('lessonsOverview')
        .doc('Lesson 1')
        .set({
      "lessonId": 001,
      "lessonName": "Lesson 1",
      "lessonDesc": "Greeting Signs",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('lessonsOverview')
        .doc('Lesson 2')
        .set({
      "lessonId": 002,
      "lessonName": "Lesson 2",
      "lessonDesc": "Greeting Signs 2",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('lessonsOverview')
        .doc('Lesson 3')
        .set({
      "lessonId": 003,
      "lessonName": "Lesson 3",
      "lessonDesc": "Asking Signs",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('lessonsOverview')
        .doc('Lesson 4')
        .set({
      "lessonId": 004,
      "lessonName": "Lesson 4",
      "lessonDesc": "Responsive Signs",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('lessonsOverview')
        .doc('Lesson 5')
        .set({
      "lessonId": 005,
      "lessonName": "Lesson 5",
      "lessonDesc": "Common Signs \nin Asking",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('lessonsOverview')
        .doc('Lesson 6')
        .set({
      "lessonId": 006,
      "lessonName": "Lesson 6",
      "lessonDesc": "Last Lesson!!!",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    ///To Syllabus 2 Lesson Overview

    ///From Syllabus 3 Lesson Overview
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('lessonsOverview')
        .doc('Lesson 1')
        .set({
      "lessonId": 001,
      "lessonName": "Lesson 1",
      "lessonDesc": "Alphabet A-E",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('lessonsOverview')
        .doc('Lesson 2')
        .set({
      "lessonId": 002,
      "lessonName": "Lesson 2",
      "lessonDesc": "Alphabet F-J",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('lessonsOverview')
        .doc('Lesson 3')
        .set({
      "lessonId": 003,
      "lessonName": "Lesson 3",
      "lessonDesc": "Alphabet K-O",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('lessonsOverview')
        .doc('Lesson 4')
        .set({
      "lessonId": 004,
      "lessonName": "Lesson 4",
      "lessonDesc": "Alphabet P-T",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 3')
        .collection('lessonsOverview')
        .doc('Lesson 5')
        .set({
      "lessonId": 005,
      "lessonName": "Lesson 5",
      "lessonDesc": "Alphabet U-Z",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    ///To Syllabus 3 Lesson Overview

    ///From Syllabus 4 Lesson Overview
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('lessonsOverview')
        .doc('Lesson 1')
        .set({
      "lessonId": 001,
      "lessonName": "Lesson 1",
      "lessonDesc": "Greeting Signs",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('lessonsOverview')
        .doc('Lesson 2')
        .set({
      "lessonId": 002,
      "lessonName": "Lesson 2",
      "lessonDesc": "Greeting Signs 2",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('lessonsOverview')
        .doc('Lesson 3')
        .set({
      "lessonId": 003,
      "lessonName": "Lesson 3",
      "lessonDesc": "Asking Signs",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('lessonsOverview')
        .doc('Lesson 4')
        .set({
      "lessonId": 004,
      "lessonName": "Lesson 4",
      "lessonDesc": "Responsive Signs",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('lessonsOverview')
        .doc('Lesson 5')
        .set({
      "lessonId": 005,
      "lessonName": "Lesson 5",
      "lessonDesc": "Common Signs \nin Asking",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Syllabus 4')
        .collection('lessonsOverview')
        .doc('Lesson 6')
        .set({
      "lessonId": 006,
      "lessonName": "Lesson 6",
      "lessonDesc": "Last Lesson!!!",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    ///To Syllabus 4 Lesson Overview

    ///From Overview Collection
    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Overview')
        .collection('Overview')
        .doc('Syllabus 1')
        .set({
      "lessonId": 001,
      "lessonName": "Lesson 1",
      "lessonDesc": "Alphabets",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Overview')
        .collection('Overview')
        .doc('Syllabus 2')
        .set({
      "lessonId": 002,
      "lessonName": "Lesson 2",
      "lessonDesc": "Basic Signs",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Overview')
        .collection('Overview')
        .doc('Syllabus 3')
        .set({
      "lessonId": 003,
      "lessonName": "Practical 1",
      "lessonDesc": "Assignments",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    await userCollection
        .doc(uid)
        .collection('lessons')
        .doc('Overview')
        .collection('Overview')
        .doc('Syllabus 4')
        .set({
      "lessonId": 004,
      "lessonName": "Practical 2",
      "lessonDesc": "Sentences",
      "lessonImage": "assets/image/lesson_1_thumbnail.png",
      "isCompleted": false,
    });

    ///To Overview Collection
  }

  Future<void> buildUserLog() async {
    print("reached");

    ///From Log Collection
    await userCollection.doc(uid).collection('log').doc('Activity').set({
      "lastLoginIn": Timestamp.now(),
      "login": [false, false, false, false, false, false, false],
    });

    ///To Log Collection
  }

  Future<void> buildUserFriend() async {
    await userCollection.doc(uid).collection("friends").doc("friends").set({
      "list": [],
    });
  }

  ///To User Collection

  ///From Lesson Collection
  //get everything in lesson as List<Map<String, String>>
  Future<List> getWordData() async {
    List wordData = [];
    List syllabus = ['Syllabus 1', 'Syllabus 2'];
    for (String each in syllabus) {
      await lessonsCollection
          .doc(each)
          .collection('Syllabus')
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((doc) {
          wordData.add(doc.data());
        });
      });
    }

    return wordData;
  }

  ///To Lesson Collection

  ///From Feedback Collection
  Future submitFeedbackForm(String category, String subject, String desc,
      String email, String imgDownloadLink, String name) async {
    return await feedbackCollection.doc(category).collection(uid!).add({
      "subject": subject,
      "description": desc,
      "email": email,
      "imageUrl": imgDownloadLink,
      "name": name,
    });
  }

  ///To Feedback Collection

  ///From Community Collection
  List<CommunityModel_1>? _communityListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CommunityModel_1(
          content: doc['content'],
          media: doc['media'],
          participant: List.from(doc['participant']),
          title: doc['title']);
    }).toList();
  }

  Stream<List<CommunityModel_1>?> get communityList {
    return newsCollection.snapshots().map(_communityListFromSnapshot);
  }

  ///To Community Collection

  ///From News Collection
  List<NewsFeedModel>? _newsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return NewsFeedModel(
        doc['id'],
        doc['title'],
        doc['content'],
        doc['media'],
        doc['timestamp'],
        doc['author'],
      );
    }).toList();
  }

  Stream<List<NewsFeedModel>?> get newsList {
    return newsCollection.snapshots().map(_newsListFromSnapshot);
  }

  ///To News Collection

  ///Normal methods....
  double daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24);
  }

  ///Not in use
  //Dictionary Provider
  List<WordModel>? _dictionaryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return WordModel(
          word: doc['word'],
          imgUrl: doc['imgUrl'],
          definition: doc['definition'],
          phoneticSymbol: doc['phoneticSymbol']);
    }).toList();
  }

  Stream<List<WordModel>?> get wordData {
    Stream<List<WordModel>?> x = FirebaseFirestore.instance
        .collection('lessons')
        .doc('Syllabus 1')
        .collection('Syallbus')
        .snapshots()
        .map(_dictionaryListFromSnapshot);
    Stream<List<WordModel>?> y = FirebaseFirestore.instance
        .collection('lessons')
        .doc('Syllabus 2')
        .collection('Syallbus')
        .snapshots()
        .map(_dictionaryListFromSnapshot);

    return StreamGroup.merge([x, y]).asBroadcastStream();
  }

  //user list from snapshot
  List<Users> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Users(
        name: doc['name'],
        experience: doc['experience'],
        phoneNumber: doc['phoneNumber'],
        picture: doc['picture'],
        title: doc['title'],
        username: doc['username'],
        uid: doc["uid"],
      );
    }).toList();
  }

  // get user stream
  Stream<List<Users>?> get users {
    Stream<List<Users>?> x = userCollection
        .orderBy('experience', descending: true)
        .snapshots()
        .map(_userListFromSnapshot);
    return x;
  }

  Stream<List<Users>> usersByQuery(String query) {
    Stream<List<Users>> a = userCollection
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: query + 'z')
        .snapshots()
        .map(_userListFromSnapshot);
    Stream<List<Users>> b = userCollection
        .where('username', isGreaterThanOrEqualTo: query)
        .where('username', isLessThan: query + 'z')
        .snapshots()
        .map(_userListFromSnapshot);

    return StreamGroup.merge([a, b]).asBroadcastStream();
  }

  Stream<List<Users>> usersByUIds(List<String> uids) {
    if (uids.isEmpty) {
      uids.add("thisIsADummyTextToPreventError");
    }
    return userCollection
        .where("uid", whereIn: uids)
        .snapshots()
        .map(_userListFromSnapshot);
  }

  List<String> _friendIdFromSnapshot(DocumentSnapshot snapshot) {
    List<String> fUid = List.from(snapshot["list"]);

    return fUid;
  }

  List<ChatRoom> _chatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ChatRoom(
          createdAt: doc["createdAt"] as Timestamp,
          createdBy: doc["createdBy"] as String,
          participants: List.from(doc["participants"]),
          recentMessageText: doc["recentMsg"]["messageText"] as String,
          recentSentAt: doc["recentMsg"]["sentAt"] as Timestamp,
          recentSentBy: doc["recentMsg"]["sentBy"] as String,
          roomId: doc["roomId"] as String,
          roomName: doc["roomName"],
          roomPicture: doc["roomPicture"],
          type: doc["type"] as int);
    }).toList();
  }

  Users _singleUserFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) {
          return Users(
            name: doc['name'],
            experience: doc['experience'],
            phoneNumber: doc['phoneNumber'],
            picture: doc['picture'],
            title: doc['title'],
            username: doc['username'],
            uid: doc["uid"],
          );
        })
        .toList()
        .first;
  }

  Stream<Users> getSingleFriendById(String id) {
    return userCollection
        .where('uid', isEqualTo: id)
        .snapshots()
        .map(_singleUserFromSnapshot);
  }

  Stream<List<Users>?> friends(List<dynamic> friendIds) {
    return userCollection
        .where("uid", whereIn: friendIds)
        .snapshots()
        .map(_userListFromSnapshot);
  }

  Stream<List<ChatRoom>> chats(List<String> chatIds) {
    return chatRoomCollection
        .where("roomId", whereIn: chatIds)
        .snapshots()
        .map(_chatListFromSnapshot);
  }

  Stream<List<String>> get chatsId {
    return userCollection.doc(uid).snapshots().map((snapshot) {
      List<String> a = List<String>.from(snapshot['groups']);
      // print("Number of elem is ${a.length}");
      return a;
    });
  }

  Stream<List<String>> get friendsId {
    return userCollection
        .doc(uid)
        .collection("friends")
        .doc('friends')
        .snapshots()
        .map(_friendIdFromSnapshot);
  }

  Stream<List<String>> get excludeUserIdForGlobal {
    // get alr fren
    Stream<List<String>> a = userCollection
        .doc(uid)
        .collection("friends")
        .doc('friends')
        .snapshots()
        .map(_friendIdFromSnapshot);
    // get other side alr sent request
    Stream<List<String>> b = userCollection
        .doc(uid)
        .collection('friend_requests')
        .snapshots()
        .map(_friendRequestListFromSnapshot);
    return CombineLatestStream.combine2(a, b, (List<String> x, List<String> y) {
      return <String>[...x, ...y];
    });
  }

  Stream<List<String>> currentFriendRequests(String otherSideId) {
    return userCollection
        .doc(otherSideId)
        .collection("friend_requests")
        .snapshots()
        .map(_friendRequestListFromSnapshot);
  }

  List<Messages> _messagesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Messages(
        sentAt: doc["sentAt"] as Timestamp,
        sentBy: doc["sentBy"] as String,
        messageText: doc["messageText"] as String,
        type: doc["type"] as int,
      );
    }).toList();
  }

  Stream<List<Messages>> messages(String roomId) {
    return chatRoomCollection
        .doc(roomId)
        .collection("messages")
        .orderBy("sentAt", descending: true)
        .snapshots()
        .map(_messagesFromSnapshot);
  }

  Future<void> sendMessage(String roomId, String messageText, String senderName,
      {bool isMedia = false}) async {
    // add messages to collection "messages", if collection not found will create one
    if (!isMedia) {
      await chatRoomCollection.doc(roomId).collection("messages").doc().set({
        "messageText": messageText,
        "sentAt": Timestamp.now(),
        "sentBy": uid,
        "type": 1,
      });
      // update recent message field
      await chatRoomCollection.doc(roomId).update({
        "recentMsg": {
          "messageText": messageText,
          "sentAt": Timestamp.now(),
          "sentBy": uid,
          "type": 1,
        }
      });
    } else {
      await chatRoomCollection.doc(roomId).collection("messages").doc().set({
        "messageText": messageText,
        "sentAt": Timestamp.now(),
        "sentBy": uid,
        "type": 2,
      });
      // update recent message field
      await chatRoomCollection.doc(roomId).update({
        "recentMsg": {
          "messageText": "sent an image",
          "sentAt": Timestamp.now(),
          "sentBy": uid,
          "type": 2,
        }
      });
    }

    //TODO: get senderName

    Map<String, dynamic> data = {
      'name': senderName,
      'roomId': roomId,
    };

    connectFunction('chatNoti', data);
  }

  Future<void> updateToken(String token, DateTime now, String uid) async {
    await devicesCollection.doc(token).set({
      "timestamp": Timestamp.now(),
      "uid": uid,
      "token": token,
    });
    UserPreference.setValue("tokenUpdated", now.toString());
    UserPreference.setValue("token", token);
    print("Token is updated to db and shared preference");
  }

  Future<void> saveToken(String? token, String uid) async {
    if (token == null) return;
    print(token);

    final now = DateTime.now();
    final tokenUpdated = UserPreference.get("tokenUpdated");
    DateTime lastUpdate = now;

    final deviceToken = UserPreference.get("token");

    if (deviceToken == null || deviceToken != token) {
      updateToken(token, now, uid);
    } else {
      if (tokenUpdated != null) {
        lastUpdate = DateTime.parse(tokenUpdated);
        print("Token last updated on $lastUpdate");
      }

      // update database after 1 month
      if (tokenUpdated == null ||
          lastUpdate.add(const Duration(days: 30)).isBefore(now)) {
        updateToken(token, now, uid);
      }
    }
  }
}
