import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:handsfree/models/newUser.dart';
import 'package:handsfree/models/wordModel.dart';
import 'package:handsfree/services/auth.dart';
import '../models/userProfile.dart';
import 'package:flamingo/flamingo.dart';
import 'package:flamingo_annotation/flamingo_annotation.dart';

class DatabaseService{

  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference chatRoomCollection = FirebaseFirestore.instance.collection('chatRoom');
  final CollectionReference messageCollection = FirebaseFirestore.instance.collection('message');
  final CollectionReference lessonsCollection = FirebaseFirestore.instance.collection('lessons');
  final CollectionReference contributorCollection = FirebaseFirestore.instance.collection('contributor');
  final CollectionReference newsCollection = FirebaseFirestore.instance.collection('news');
  final CollectionReference leaderboardCollection = FirebaseFirestore.instance.collection('leaderboard');

  //new user register
  Future updateUserData(int experience, String phoneNumber, String picture, String title, String username) async {
    return await userCollection.doc(uid).set({
      'experience': experience,
      'phoneNumber': phoneNumber,
      'picture': picture,
      'title': title,
      'username': username,
    }).then((_){
      print("Success!");
    });
  }

  Future updateSingleData(String selector, String value) async{
    if(selector == 'name') {
      return await userCollection.doc(uid).update({
        'name': value,
      });
    }

    else if(selector == 'username') {
      return await userCollection.doc(uid).update({
        'username': value,
      });
    }

    else if(selector == 'password'){
      AuthService().changePassword(value);
      return;
    }

    else if(selector == 'title'){
      return await userCollection.doc(uid).update({
        'title': value,
      });
    }

    else if (selector == 'none'){
      return;
    }

    else{
      print('Return Nothing');
      return;
    }
  }

  //user list from snapshot
  List<Users>? _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Users(
        name: doc['name'],
        experience: doc['experience'],
        phoneNumber: doc['phoneNumber'],
        picture: doc['picture'],
        title: doc['title'],
        username: doc['username'],
      );
    }).toList();
  }

  // get user stream
  Stream<List<Users>?> get users{
    Stream<List<Users>?> x = userCollection.snapshots()
        .map(_userListFromSnapshot);
    return x;
  }


  //NewUserData from snapshot aka single data of specific user
  NewUserData _userDataFromSnapsot(DocumentSnapshot snapshot){
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

  //get user doc stream
  Stream<NewUserData> get userData {
    return userCollection.doc(uid).snapshots()
        .map(_userDataFromSnapsot);
  }

  //Dictionary Provider
  List<WordModel>? _dictionaryListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return WordModel(
          word: doc['word'],
          imgUrl: doc['imgUrl'],
          definition: doc['definition'],
          phoneticSymbol: doc['phoneticSymbol']
      );
    }).toList();
  }

  Stream<List<WordModel>?> get wordData {
    Stream<List<WordModel>?> x = FirebaseFirestore.instance.collection('lessons').doc('Syllabus 1').collection('Syallbus').snapshots()
        .map(_dictionaryListFromSnapshot);
    Stream<List<WordModel>?> y = FirebaseFirestore.instance.collection('lessons').doc('Syllabus 2').collection('Syallbus').snapshots()
        .map(_dictionaryListFromSnapshot);

    return StreamGroup.merge([x,y]).asBroadcastStream();
  }

  //individual user login activity
  NewUserActivityLog _userActivityLog(DocumentSnapshot snapshot){
    return NewUserActivityLog(
      corrector: snapshot['corrector'],
      activity: List.from(snapshot['login']),
    );
  }

  Stream<NewUserActivityLog> get activity{
    return userCollection.doc(uid).collection('log').doc('Activity').snapshots()
        .map(_userActivityLog);
  }

  //get everything in lesson as List<Map<String, String>>
  List getWordData() {
    List wordData = [{'definition': '', 'word': '', 'phoneticSymbol': '', 'imgUrl': ''}];
    List syllabus = ['Syllabus 1', 'Syllabus 2'];
    for (String each in syllabus) {
      lessonsCollection.doc(each).collection('Syllabus').get().then((snapshot) {
        snapshot.docs.forEach((doc) {
          wordData.add(doc.data());
        });
      });
    }
    return wordData;
  }
}


