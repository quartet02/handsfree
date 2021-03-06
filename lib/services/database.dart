import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handsfree/models/achievementModel.dart';
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
import 'package:handsfree/widgets/constants.dart';
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
  Future<void> updateSingleData(
      CollectionSelector selector, String value) async {
    if (selector == CollectionSelector.name) {
      await userCollection.doc(uid).update({
        'name': value,
      });
      // .onError((error, stackTrace) => 400)
      // .whenComplete(() => 200);
    } else if (selector == CollectionSelector.username) {
      await userCollection.doc(uid).update({
        'username': value,
      });
      // .onError((error, stackTrace) => 400)
      // .whenComplete(() => 200);
    } else if (selector == CollectionSelector.password) {
      AuthService().changePassword(value);
    } else if (selector == CollectionSelector.title) {
      await userCollection.doc(uid).update({
        'title': value,
      });
      // .onError((error, stackTrace) => 400)
      // .whenComplete(() => 200);
    } else if (selector == CollectionSelector.email) {
      await userCollection.doc(uid).update({
        'email': value,
      });
      // .onError((error, stackTrace) => 400)
      // .whenComplete(() => 200);
    } else {
      // return 400;
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

  Future updateTestResult(
      String syllabus,
      String lesson,
      List<String> lessonId,
      List<int> allTypeOfTest,
      List<int> numOfWrong,
      List<Duration> elapsedTime) {
    debugPrint(numOfWrong.toString());
    debugPrint(elapsedTime.toString());
    List<int> time = [];
    for (Duration each in elapsedTime) {
      time.add(each.inMicroseconds);
    }
    return userCollection
        .doc(uid)
        .collection('lessons')
        .doc(syllabus)
        .collection('lessonsOverview')
        .doc(lesson)
        .update({
      'testLessonsId': lessonId,
      'allTypeOfTest': allTypeOfTest,
      'numOfWrong': numOfWrong,
      'elapsedTime': time,
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

  // for future builder in mainLearningPage
  Future<List<LessonCardModel>> getSelectedLessonCardList(
      String syllabus, String lesson) async {
    List<LessonCardModel> list = [];
    QuerySnapshot<Map<String, dynamic>> snapshots = await userCollection
        .doc(uid)
        .collection('lessons')
        .doc(syllabus)
        .collection(lesson)
        .get();

    debugPrint("FirebaseGetSelectedLessonCardList: " +
        syllabus +
        " " +
        lesson +
        "sfsf");

    for (var doc in snapshots.docs) {
      Map<String, dynamic> temp = doc.data();

      list.add(LessonCardModel(
          lessonCardId: temp["lessonCardId"],
          lessonCardTitle: temp["lessonCardTitle"],
          lessonCardDesc: temp["lessonCardDesc"],
          lessonCardImage: temp["lessonCardImage"],
          lessonId: temp["lessonId"],
          isCompleted: temp["isCompleted"]));
    }

    return list;
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

  Future updateActivityLog(List? activityLog, Timestamp? time) {
    DateTime now = DateTime.now();
    DateTime last = DateTime.parse(time!.toDate().toString());
    double days = daysBetween(last, now);

    ///refresh on sunday
    ///login on saturday, skip sunday, login on monday
    ///duration more than 7 days
    ///on same date(Friday and Friday, but different week)
    activityLog![now.weekday < 7 ? now.weekday : 0] = true;
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
      "endorsedCount": 0,
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

  Future<void> sendFriendRequest(String otherSideId, String senderName) async {
    Map<String, dynamic> data = {
      'receiverUid': otherSideId,
      'name': senderName,
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
      "lessonCardImage": "assets/word/a.png",
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
      "lessonCardImage": "assets/word/b.png",
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
      "lessonCardImage": "assets/word/c.png",
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
      "lessonCardImage": "assets/word/d.png",
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
      "lessonCardImage": "assets/word/e.png",
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
      "lessonCardId": 006,
      "lessonCardTitle": "F",
      "lessonCardDesc": "Alphabet F",
      "lessonCardImage": "assets/word/f.png",
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
      "lessonCardId": 007,
      "lessonCardTitle": "G",
      "lessonCardDesc": "Alphabet G",
      "lessonCardImage": "assets/word/g.png",
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
      "lessonCardId": 008,
      "lessonCardTitle": "H",
      "lessonCardDesc": "Alphabet H",
      "lessonCardImage": "assets/word/h.png",
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
      "lessonCardId": 009,
      "lessonCardTitle": "I",
      "lessonCardDesc": "Alphabet I",
      "lessonCardImage": "assets/word/i.png",
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
      "lessonCardId": 010,
      "lessonCardTitle": "J",
      "lessonCardDesc": "Alphabet J",
      "lessonCardImage": "assets/word/j.gif",
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
      "lessonCardId": 011,
      "lessonCardTitle": "K",
      "lessonCardDesc": "Alphabet K",
      "lessonCardImage": "assets/word/k.png",
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
      "lessonCardId": 012,
      "lessonCardTitle": "L",
      "lessonCardDesc": "Alphabet L",
      "lessonCardImage": "assets/word/l.png",
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
      "lessonCardId": 013,
      "lessonCardTitle": "M",
      "lessonCardDesc": "Alphabet M",
      "lessonCardImage": "assets/word/m.png",
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
      "lessonCardId": 014,
      "lessonCardTitle": "N",
      "lessonCardDesc": "Alphabet n",
      "lessonCardImage": "assets/word/n.png",
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
      "lessonCardId": 015,
      "lessonCardTitle": "O",
      "lessonCardDesc": "Alphabet O",
      "lessonCardImage": "assets/word/o.png",
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
      "lessonCardId": 016,
      "lessonCardTitle": "P",
      "lessonCardDesc": "Alphabet P",
      "lessonCardImage": "assets/word/p.png",
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
      "lessonCardId": 017,
      "lessonCardTitle": "Q",
      "lessonCardDesc": "Alphabet Q",
      "lessonCardImage": "assets/word/q.png",
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
      "lessonCardId": 018,
      "lessonCardTitle": "R",
      "lessonCardDesc": "Alphabet R",
      "lessonCardImage": "assets/word/r.png",
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
      "lessonCardId": 019,
      "lessonCardTitle": "S",
      "lessonCardDesc": "Alphabet S",
      "lessonCardImage": "assets/word/s.png",
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
      "lessonCardId": 020,
      "lessonCardTitle": "T",
      "lessonCardDesc": "Alphabet T",
      "lessonCardImage": "assets/word/t.png",
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
      "lessonCardId": 021,
      "lessonCardTitle": "U",
      "lessonCardDesc": "Alphabet U",
      "lessonCardImage": "assets/word/u.png",
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
      "lessonCardId": 022,
      "lessonCardTitle": "V",
      "lessonCardDesc": "Alphabet V",
      "lessonCardImage": "assets/word/v.png",
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
      "lessonCardId": 023,
      "lessonCardTitle": "W",
      "lessonCardDesc": "Alphabet W",
      "lessonCardImage": "assets/word/w.png",
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
      "lessonCardId": 024,
      "lessonCardTitle": "X",
      "lessonCardDesc": "Alphabet X",
      "lessonCardImage": "assets/word/x.png",
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
      "lessonCardId": 025,
      "lessonCardTitle": "Y",
      "lessonCardDesc": "Alphabet Y",
      "lessonCardImage": "assets/word/y.png",
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
      "lessonCardId": 026,
      "lessonCardTitle": "Z",
      "lessonCardDesc": "Alphabet Z",
      "lessonCardImage": "assets/word/z.gif",
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
      "lessonCardId": 027,
      "lessonCardTitle": "Hello",
      "lessonCardDesc": "Sign of 'Hello'",
      "lessonCardImage": "assets/word/hello.gif",
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
      "lessonCardId": 028,
      "lessonCardTitle": "Hey",
      "lessonCardDesc": "Sign of 'Hey'",
      "lessonCardImage": "assets/word/hey.gif",
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
      "lessonCardId": 029,
      "lessonCardTitle": "What's up",
      "lessonCardDesc": "Sign of 'What's up'",
      "lessonCardImage": "assets/word/whatsupp.gif",
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
      "lessonCardId": 030,
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
      "lessonCardId": 031,
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
      "lessonCardId": 032,
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
      "lessonCardId": 033,
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
      "lessonCardId": 034,
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
      "lessonCardId": 035,
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
      "lessonCardId": 036,
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
      "lessonCardId": 037,
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
      "lessonCardId": 038,
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
      "lessonCardId": 039,
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
      "lessonCardId": 040,
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
      "lessonCardId": 041,
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
      "lessonCardId": 042,
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
      "lessonCardId": 043,
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
      "lessonCardId": 044,
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
      "lessonCardId": 045,
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
      "lessonCardId": 046,
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
      "lessonCardId": 047,
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
      "lessonCardId": 048,
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
      "lessonCardId": 049,
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
      "lessonCardId": 050,
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
      "lessonCardId": 051,
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
      "lessonCardId": 052,
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
      "lessonCardId": 053,
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
      "lessonCardId": 054,
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
      "lessonCardId": 055,
      "lessonCardTitle": "Goodbye",
      "lessonCardDesc": "Sign of 'Goodbye'",
      "lessonCardImage": "assets/word/goodbye.gif",
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
      "lessonCardId": 056,
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
      "lessonCardId": 057,
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
      "lessonCardId": 058,
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
      "lessonCardImage": "assets/word/a.png",
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
      "lessonCardImage": "assets/word/b.png",
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
      "lessonCardImage": "assets/word/c.png",
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
      "lessonCardImage": "assets/word/d.png",
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
      "lessonCardImage": "assets/word/e.png",
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
      "lessonCardId": 006,
      "lessonCardTitle": "F",
      "lessonCardDesc": "Alphabet F",
      "lessonCardImage": "assets/word/f.png",
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
      "lessonCardId": 007,
      "lessonCardTitle": "G",
      "lessonCardDesc": "Alphabet G",
      "lessonCardImage": "assets/word/g.png",
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
      "lessonCardId": 008,
      "lessonCardTitle": "H",
      "lessonCardDesc": "Alphabet H",
      "lessonCardImage": "assets/word/h.png",
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
      "lessonCardId": 009,
      "lessonCardTitle": "I",
      "lessonCardDesc": "Alphabet I",
      "lessonCardImage": "assets/word/i.png",
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
      "lessonCardId": 010,
      "lessonCardTitle": "J",
      "lessonCardDesc": "Alphabet J",
      "lessonCardImage": "assets/word/j.gif",
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
      "lessonCardId": 011,
      "lessonCardTitle": "K",
      "lessonCardDesc": "Alphabet K",
      "lessonCardImage": "assets/word/k.png",
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
      "lessonCardId": 012,
      "lessonCardTitle": "L",
      "lessonCardDesc": "Alphabet L",
      "lessonCardImage": "assets/word/l.png",
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
      "lessonCardId": 013,
      "lessonCardTitle": "M",
      "lessonCardDesc": "Alphabet M",
      "lessonCardImage": "assets/word/m.png",
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
      "lessonCardId": 014,
      "lessonCardTitle": "N",
      "lessonCardDesc": "Alphabet n",
      "lessonCardImage": "assets/word/n.png",
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
      "lessonCardId": 015,
      "lessonCardTitle": "O",
      "lessonCardDesc": "Alphabet O",
      "lessonCardImage": "assets/word/o.png",
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
      "lessonCardId": 016,
      "lessonCardTitle": "P",
      "lessonCardDesc": "Alphabet P",
      "lessonCardImage": "assets/word/p.png",
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
      "lessonCardId": 017,
      "lessonCardTitle": "Q",
      "lessonCardDesc": "Alphabet Q",
      "lessonCardImage": "assets/word/q.png",
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
      "lessonCardId": 018,
      "lessonCardTitle": "R",
      "lessonCardDesc": "Alphabet R",
      "lessonCardImage": "assets/word/r.png",
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
      "lessonCardId": 019,
      "lessonCardTitle": "S",
      "lessonCardDesc": "Alphabet S",
      "lessonCardImage": "assets/word/s.png",
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
      "lessonCardId": 020,
      "lessonCardTitle": "T",
      "lessonCardDesc": "Alphabet T",
      "lessonCardImage": "assets/word/t.png",
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
      "lessonCardId": 021,
      "lessonCardTitle": "U",
      "lessonCardDesc": "Alphabet U",
      "lessonCardImage": "assets/word/u.png",
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
      "lessonCardId": 022,
      "lessonCardTitle": "V",
      "lessonCardDesc": "Alphabet V",
      "lessonCardImage": "assets/word/v.png",
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
      "lessonCardId": 023,
      "lessonCardTitle": "W",
      "lessonCardDesc": "Alphabet W",
      "lessonCardImage": "assets/word/w.png",
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
      "lessonCardId": 024,
      "lessonCardTitle": "X",
      "lessonCardDesc": "Alphabet X",
      "lessonCardImage": "assets/word/x.png",
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
      "lessonCardId": 025,
      "lessonCardTitle": "Y",
      "lessonCardDesc": "Alphabet Y",
      "lessonCardImage": "assets/word/y.png",
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
      "lessonCardId": 026,
      "lessonCardTitle": "Z",
      "lessonCardDesc": "Alphabet Z",
      "lessonCardImage": "assets/word/z.gif",
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
      "lessonCardId": 027,
      "lessonCardTitle": "Hello",
      "lessonCardDesc": "Sign of 'Hello'",
      "lessonCardImage": "assets/word/hello.gif",
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
      "lessonCardId": 028,
      "lessonCardTitle": "Hey",
      "lessonCardDesc": "Sign of 'Hey'",
      "lessonCardImage": "assets/word/hey.gif",
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
      "lessonCardId": 029,
      "lessonCardTitle": "What's up",
      "lessonCardDesc": "Sign of 'What's up'",
      "lessonCardImage": "assets/word/whatsupp.gif",
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
      "lessonCardId": 030,
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
      "lessonCardId": 031,
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
      "lessonCardId": 032,
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
      "lessonCardId": 033,
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
      "lessonCardId": 034,
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
      "lessonCardId": 035,
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
      "lessonCardId": 036,
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
      "lessonCardId": 037,
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
      "lessonCardId": 038,
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
      "lessonCardId": 039,
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
      "lessonCardId": 040,
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
      "lessonCardId": 041,
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
      "lessonCardId": 042,
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
      "lessonCardId": 043,
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
      "lessonCardId": 044,
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
      "lessonCardId": 045,
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
      "lessonCardId": 046,
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
      "lessonCardId": 047,
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
      "lessonCardId": 048,
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
      "lessonCardId": 049,
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
      "lessonCardId": 050,
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
      "lessonCardId": 051,
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
      "lessonCardId": 052,
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
      "lessonCardId": 053,
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
      "lessonCardId": 054,
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
      "lessonCardId": 055,
      "lessonCardTitle": "Goodbye",
      "lessonCardDesc": "Sign of 'Goodbye'",
      "lessonCardImage": "assets/word/goodbye.gif",
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
      "lessonCardId": 056,
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
      "lessonCardId": 057,
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
      "lessonCardId": 058,
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
      "lessonImage": "assets/sublevel/Group 97.png",
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
      "lessonImage": "assets/sublevel/Group 98.png",
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
      "lessonImage": "assets/sublevel/Group 99.png",
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
      "lessonImage": "assets/sublevel/Group 100.png",
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
      "lessonImage": "assets/sublevel/Group 101.png",
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
      "lessonImage": "assets/sublevel/Group 109.png",
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
      "lessonImage": "assets/sublevel/Group 108.png",
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
      "lessonImage": "assets/sublevel/Group 107.png",
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
      "lessonImage": "assets/sublevel/Group 106.png",
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
      "lessonImage": "assets/sublevel/Group 105.png",
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
      "lessonImage": "assets/sublevel/Group 102.png",
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
      "lessonImage": "assets/sublevel/Group 97.png",
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
      "lessonImage": "assets/sublevel/Group 98.png",
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
      "lessonImage": "assets/sublevel/Group 99.png",
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
      "lessonImage": "assets/sublevel/Group 100.png",
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
      "lessonImage": "assets/sublevel/Group 101.png",
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
      "lessonImage": "assets/sublevel/Group 109.png",
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
      "lessonImage": "assets/sublevel/Group 108.png",
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
      "lessonImage": "assets/sublevel/Group 107.png",
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
      "lessonImage": "assets/sublevel/Group 106.png",
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
      "lessonImage": "assets/sublevel/Group 105.png",
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
      "lessonImage": "assets/sublevel/Group 102.png",
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
      "lessonImage": "assets/sublevel/Group 119.png",
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
      "lessonImage": "assets/sublevel/Group 118.png",
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
      "lessonImage": "assets/sublevel/Group 120.png",
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
      "lessonImage": "assets/sublevel/Group 117.png",
      "isCompleted": false,
    });

    ///To Overview Collection

    ///From Achievement Collection
    await userCollection.doc(uid).collection('achievement').doc('sensei').set({
      "achievementId": 001,
      "achievementName": "Sensei",
      "achievementDesc": "Teach many people",
      "achievementImage": "assets/achievement/sensei.png",
      "isAchieved": false,
    });

    await userCollection
        .doc(uid)
        .collection('achievement')
        .doc('theflash')
        .set({
      "achievementId": 002,
      "achievementName": "The Flash",
      "achievementDesc": "Complete the whole course in 24 hours",
      "achievementImage": "assets/achievement/theflash.png",
      "isAchieved": false,
    });

    await userCollection
        .doc(uid)
        .collection('achievement')
        .doc('thegiver')
        .set({
      "achievementId": 003,
      "achievementName": "The giver",
      "achievementDesc":
          "You are loved as you have contributed many materials <3",
      "achievementImage": "assets/achievement/thegiver.png",
      "isAchieved": false,
    });

    await userCollection
        .doc(uid)
        .collection('achievement')
        .doc('whatacomeback')
        .set({
      "achievementId": 004,
      "achievementName": "What a come back",
      "achievementDesc": "Logged in after 1 month",
      "achievementImage": "assets/achievement/whatacomeback.png",
      "isAchieved": false,
    });

    ///To Achievement Collection

    ///From Endorsed Collection
    await userCollection
        .doc(uid)
        .collection('endorsed')
        .doc('endorsed')
        .set({"endorsedList": FieldValue.arrayUnion([])});

    ///To Endorsed Collection
  }

  Future<void> updateDB() async {
    await userCollection
        .doc(uid)
        .collection('endorsed')
        .doc('endorsed')
        .set({"endorsedList": FieldValue.arrayUnion([])});
  }

  Future<void> buildUserLog() async {
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
        doc['authorPic'],
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

  Future<List<String>> get usersId async {
    return await userCollection.get().then((query) {
      return query.docs
          .map((doc) {
            return doc["uid"];
          })
          .toList()
          .cast<String>();
    });
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

  Stream<List<String>> getEndorsedList() {
    return userCollection
        .doc(uid)
        .collection("endorsed")
        .doc("endorsed")
        .snapshots()
        .map(_endorsedListFromSnapshot);
  }

  Future<List<String>> getFutureEndorsedList() {
    return userCollection
        .doc(uid)
        .collection("endorsed")
        .doc("endorsed")
        .get()
        .then((value) => List.from(value["endorsedList"]));
  }

  List<String> _endorsedListFromSnapshot(DocumentSnapshot snapshot) {
    return List.from(snapshot["endorsedList"]);
  }

  Stream<List<NewsFeedModel>?> newsFeedByQuery(String query) {
    Stream<List<NewsFeedModel>?> a = newsCollection
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThan: query + 'z')
        .snapshots()
        .map(_newsListFromSnapshot);
    Stream<List<NewsFeedModel>?> b = newsCollection
        .where('content', isGreaterThanOrEqualTo: query)
        .where('content', isLessThan: query + 'z')
        .snapshots()
        .map(_newsListFromSnapshot);
    Stream<List<NewsFeedModel>?> c = newsCollection
        .where('id', isGreaterThanOrEqualTo: query)
        .where('id', isLessThan: query + 'z')
        .snapshots()
        .map(_newsListFromSnapshot);

    return CombineLatestStream.combine3(a, b, c, (List<NewsFeedModel>? x,
        List<NewsFeedModel>? y, List<NewsFeedModel>? z) {
      List<NewsFeedModel> pool = (<NewsFeedModel>[
        ...x ?? [],
        ...y ?? [],
        ...z ?? []
      ]).toSet().toList();
      Map<String, NewsFeedModel> mp = {};
      for (var item in pool) {
        mp[item.id] = item;
      }
      return mp.values.toList();
    });
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

  List<Achievement> _achievementListFromSnapshot(QuerySnapshot snapshot) {
    // print("Number of achievement : " + snapshot.docs.length.toString());
    return snapshot.docs.map((doc) {
      return Achievement(
        achievementId: doc["achievementId"].toString(),
        achievementName: doc['achievementName'],
        achievementDesc: doc["achievementDesc"],
        achievementImage: doc["achievementImage"],
      );
    }).toList();
  }

  Stream<List<Achievement>> getAchievements() {
    return userCollection
        .doc(uid)
        .collection("achievement")
        .where("isAchieved", isEqualTo: true)
        .snapshots()
        .map(_achievementListFromSnapshot);
  }

  Future<Users> getUserById(String uid) {
    return userCollection.doc(uid).get().then((value) {
      return Users(
          name: value["name"],
          experience: value["experience"],
          phoneNumber: value["phoneNumber"],
          picture: value["picture"],
          title: value["title"],
          username: value["username"],
          uid: uid);
    });
  }

  Future<void> addEndorsed(String destUid) async {
    await userCollection
        .doc(destUid)
        .update({"endorsedCount": FieldValue.increment(1)}).then((value) async {
      List<String> current = await userCollection
          .doc(uid)
          .collection("endorsed")
          .doc("endorsed")
          .get()
          .then((value) {
        return List.from(value["endorsedList"]);
      });
      current.add(destUid);
      await userCollection
          .doc(uid)
          .collection("endorsed")
          .doc("endorsed")
          .update({
        "endorsedList": FieldValue.arrayUnion(<String>[destUid])
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  Future<void> removeEndorsed(String destUid) async {
    int currentCount = await userCollection
        .doc(destUid)
        .get()
        .then((value) => value["endorsedCount"] as int);
    await userCollection
        .doc(destUid)
        .update({"endorsedCount": currentCount - 1}).then((value) async {
      List<String> current = await userCollection
          .doc(uid)
          .collection("endorsed")
          .doc("endorsed")
          .get()
          .then((value) {
        return List.from(value["endorsedList"]);
      });
      current.add(destUid);
      await userCollection
          .doc(uid)
          .collection("endorsed")
          .doc("endorsed")
          .update({
        "endorsedList": FieldValue.arrayRemove(<String>[destUid])
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  Future<String> getEndorsementCount() {
    return userCollection
        .doc(uid)
        .get()
        .then((value) => value["endorsedCount"].toString());
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

    final now = DateTime.now();
    final tokenUpdated = UserPreference.get("tokenUpdated");
    DateTime lastUpdate = now;

    final deviceToken = UserPreference.get("token");

    if (deviceToken == null || deviceToken != token) {
      updateToken(token, now, uid);
    } else {
      if (tokenUpdated != null) {
        lastUpdate = DateTime.parse(tokenUpdated);
        // print("Token last updated on $lastUpdate");
      }

      // update database after 1 month
      if (tokenUpdated == null ||
          lastUpdate.add(const Duration(days: 30)).isBefore(now)) {
        updateToken(token, now, uid);
      }
    }
  }
}
