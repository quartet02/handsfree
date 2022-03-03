import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:handsfree/models/lessonCardModel.dart';
import 'package:handsfree/models/lessonModel.dart';
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
  
  void buildUserLesson() async{
    List lessons = ['Lesson 1', 'Lesson 2', 'Lesson 3', 'Lesson 4', 'Lesson 5'];
    List syllabus1 = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
                        'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
    print('Setting database');
    print(uid);

    ///Syllabus 1 Lesson 1
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 1').doc('Lesson 1').collection('Lesson 1').doc('a').set({
      "lessonCardId": 001,
      "lessonCardTitle": "A",
      "lessonCardDesc": "Alphabet A",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'a',
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 1').doc('Lesson 1').collection('Lesson 1').doc('b').set({
      "lessonCardId": 002,
      "lessonCardTitle": "B",
      "lessonCardDesc": "Alphabet B",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'b',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 1').doc('Lesson 1').collection('Lesson 1').doc('c').set({
      "lessonCardId": 003,
      "lessonCardTitle": "C",
      "lessonCardDesc": "Alphabet C",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'c',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 1').doc('Lesson 1').collection('Lesson 1').doc('d').set({
      "lessonCardId": 004,
      "lessonCardTitle": "D",
      "lessonCardDesc": "Alphabet D",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'd',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 1').doc('Lesson 1').collection('Lesson 1').doc('e').set({
      "lessonCardId": 005,
      "lessonCardTitle": "E",
      "lessonCardDesc": "Alphabet E",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'e',
      "isCompleted" : false,
    });

    ///Syllabus 1 Lesson 2
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 2').doc('Lesson 2').collection('Lesson 2').doc('f').set({
      "lessonCardId": 001,
      "lessonCardTitle": "F",
      "lessonCardDesc": "Alphabet F",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'f',
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 2').doc('Lesson 2').collection('Lesson 2').doc('g').set({
      "lessonCardId": 002,
      "lessonCardTitle": "G",
      "lessonCardDesc": "Alphabet G",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'g',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 2').doc('Lesson 2').collection('Lesson 2').doc('h').set({
      "lessonCardId": 003,
      "lessonCardTitle": "H",
      "lessonCardDesc": "Alphabet H",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'h',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 2').doc('Lesson 2').collection('Lesson 2').doc('i').set({
      "lessonCardId": 004,
      "lessonCardTitle": "I",
      "lessonCardDesc": "Alphabet I",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'i',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 2').doc('Lesson 2').collection('Lesson 2').doc('j').set({
      "lessonCardId": 005,
      "lessonCardTitle": "J",
      "lessonCardDesc": "Alphabet J",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'j',
      "isCompleted" : false,
    });

    ///Syllabus 1 Lesson 3
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 3').doc('Lesson 3').collection('Lesson 3').doc('k').set({
      "lessonCardId": 001,
      "lessonCardTitle": "K",
      "lessonCardDesc": "Alphabet K",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'k',
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 3').doc('Lesson 3').collection('Lesson 3').doc('l').set({
      "lessonCardId": 002,
      "lessonCardTitle": "L",
      "lessonCardDesc": "Alphabet L",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'l',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 3').doc('Lesson 3').collection('Lesson 3').doc('m').set({
      "lessonCardId": 003,
      "lessonCardTitle": "M",
      "lessonCardDesc": "Alphabet M",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'm',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 3').doc('Lesson 3').collection('Lesson 3').doc('n').set({
      "lessonCardId": 004,
      "lessonCardTitle": "N",
      "lessonCardDesc": "Alphabet n",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'n',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 3').doc('Lesson 3').collection('Lesson 3').doc('o').set({
      "lessonCardId": 005,
      "lessonCardTitle": "O",
      "lessonCardDesc": "Alphabet O",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'o',
      "isCompleted" : false,
    });

    ///Syllabus 1 Lesson 4
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 4').doc('Lesson 4').collection('Lesson 4').doc('p').set({
      "lessonCardId": 001,
      "lessonCardTitle": "P",
      "lessonCardDesc": "Alphabet P",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'p',
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 4').doc('Lesson 4').collection('Lesson 4').doc('q').set({
      "lessonCardId": 002,
      "lessonCardTitle": "Q",
      "lessonCardDesc": "Alphabet Q",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'q',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 4').doc('Lesson 4').collection('Lesson 4').doc('r').set({
      "lessonCardId": 003,
      "lessonCardTitle": "R",
      "lessonCardDesc": "Alphabet R",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'r',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 4').doc('Lesson 4').collection('Lesson 4').doc('s').set({
      "lessonCardId": 004,
      "lessonCardTitle": "S",
      "lessonCardDesc": "Alphabet S",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 's',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 4').doc('Lesson 4').collection('Lesson 4').doc('t').set({
      "lessonCardId": 005,
      "lessonCardTitle": "T",
      "lessonCardDesc": "Alphabet T",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 't',
      "isCompleted" : false,
    });

    ///Syllabus 1 Lesson 5
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('u').set({
      "lessonCardId": 001,
      "lessonCardTitle": "U",
      "lessonCardDesc": "Alphabet U",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'u',
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('v').set({
      "lessonCardId": 002,
      "lessonCardTitle": "V",
      "lessonCardDesc": "Alphabet V",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'v',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('w').set({
      "lessonCardId": 003,
      "lessonCardTitle": "W",
      "lessonCardDesc": "Alphabet W",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'w',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('x').set({
      "lessonCardId": 004,
      "lessonCardTitle": "X",
      "lessonCardDesc": "Alphabet X",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'x',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('y').set({
      "lessonCardId": 005,
      "lessonCardTitle": "Y",
      "lessonCardDesc": "Alphabet Y",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'y',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('z').set({
      "lessonCardId": 006,
      "lessonCardTitle": "Z",
      "lessonCardDesc": "Alphabet Z",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'z',
      "isCompleted" : false,
    });

    ///Lesson Status
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 1').doc('Lesson 1').set({
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 2').doc('Lesson 2').set({
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 3').doc('Lesson 3').set({
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 4').doc('Lesson 4').set({
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').collection('Lesson 5').doc('Lesson 5').set({
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 1').set({
      "isCompleted": false,
    });

    ///Syllabus 2 Lesson 1
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 1').doc('Lesson 1').collection('Lesson 1').doc('hello').set({
      "lessonCardId": 001,
      "lessonCardTitle": "Hello",
      "lessonCardDesc": "Sign of 'Hello'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'hello',
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 1').doc('Lesson 1').collection('Lesson 1').doc('hey').set({
      "lessonCardId": 002,
      "lessonCardTitle": "Hey",
      "lessonCardDesc": "Sign of 'Hey'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'hey',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 1').doc('Lesson 1').collection('Lesson 1').doc('whatsup').set({
      "lessonCardId": 003,
      "lessonCardTitle": "What's up",
      "lessonCardDesc": "Sign of 'What's up'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'whatsup',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 1').doc('Lesson 1').collection('Lesson 1').doc('my').set({
      "lessonCardId": 004,
      "lessonCardTitle": "My",
      "lessonCardDesc": "Sign of 'My'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'my',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 1').doc('Lesson 1').collection('Lesson 1').doc('name').set({
      "lessonCardId": 005,
      "lessonCardTitle": "Name",
      "lessonCardDesc": "Sign of 'Name'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'name',
      "isCompleted" : false,
    });

    ///Syllabus 2 Lesson 2
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 2').doc('Lesson 2').collection('Lesson 2').doc('nice').set({
      "lessonCardId": 001,
      "lessonCardTitle": "Nice",
      "lessonCardDesc": "Sign of 'Nice'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'nice',
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 2').doc('Lesson 2').collection('Lesson 2').doc('meet').set({
      "lessonCardId": 002,
      "lessonCardTitle": "Meet",
      "lessonCardDesc": "Sign of 'Meet'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'meet',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 2').doc('Lesson 2').collection('Lesson 2').doc('i').set({
      "lessonCardId": 003,
      "lessonCardTitle": "I",
      "lessonCardDesc": "Sign of 'I', which people use to mention themselves",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'i',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 2').doc('Lesson 2').collection('Lesson 2').doc('learn').set({
      "lessonCardId": 004,
      "lessonCardTitle": "Learn",
      "lessonCardDesc": "Sign of 'Learn'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'learn',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 2').doc('Lesson 2').collection('Lesson 2').doc('sign').set({
      "lessonCardId": 005,
      "lessonCardTitle": "Sign",
      "lessonCardDesc": "Sign of 'Sign'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'sign',
      "isCompleted" : false,
    });

    ///Syllabus 2 Lesson 3
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 3').doc('Lesson 3').collection('Lesson 3').doc('your').set({
      "lessonCardId": 001,
      "lessonCardTitle": "Your",
      "lessonCardDesc": "Sign of 'Your'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'your',
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 3').doc('Lesson 3').collection('Lesson 3').doc('what').set({
      "lessonCardId": 002,
      "lessonCardTitle": "What",
      "lessonCardDesc": "Sign of 'What', this sign is usually shown at the last of the signing sentence.",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'what',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 3').doc('Lesson 3').collection('Lesson 3').doc('you').set({
      "lessonCardId": 003,
      "lessonCardTitle": "You",
      "lessonCardDesc": "Sign of 'You'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'you',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 3').doc('Lesson 3').collection('Lesson 3').doc('from').set({
      "lessonCardId": 004,
      "lessonCardTitle": "From",
      "lessonCardDesc": "Sign of 'From'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'from',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 3').doc('Lesson 3').collection('Lesson 3').doc('where').set({
      "lessonCardId": 005,
      "lessonCardTitle": "Where",
      "lessonCardDesc": "Sign of 'Where', this sign is usually shown at the last of the signing sentence.",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'where',
      "isCompleted" : false,
    });

    ///Syllabus 2 Lesson 4
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 4').doc('Lesson 4').collection('Lesson 4').doc('imfine').set({
      "lessonCardId": 001,
      "lessonCardTitle": "I'm fine",
      "lessonCardDesc": "Sign of 'I'm fine'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'imfine',
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 4').doc('Lesson 4').collection('Lesson 4').doc('please').set({
      "lessonCardId": 002,
      "lessonCardTitle": "Please",
      "lessonCardDesc": "Sign of 'Please'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'please',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 4').doc('Lesson 4').collection('Lesson 4').doc('tq').set({
      "lessonCardId": 003,
      "lessonCardTitle": "Thank you",
      "lessonCardDesc": "Sign of 'Thank you'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'tq',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 4').doc('Lesson 4').collection('Lesson 4').doc('xcuseme').set({
      "lessonCardId": 004,
      "lessonCardTitle": "Excuse me",
      "lessonCardDesc": "Sign of 'Excuse me'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'xcuseme',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 4').doc('Lesson 4').collection('Lesson 4').doc('favourite').set({
      "lessonCardId": 005,
      "lessonCardTitle": "Favourite",
      "lessonCardDesc": "Sign of 'Favourite'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'favourite',
      "isCompleted" : false,
    });

    ///Syllabus 2 Lesson 5
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('place').set({
      "lessonCardId": 001,
      "lessonCardTitle": "Place",
      "lessonCardDesc": "Sign of 'Place'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'place',
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('movie').set({
      "lessonCardId": 002,
      "lessonCardTitle": "Movie",
      "lessonCardDesc": "Sign of 'Movie'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'movie',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('whatdo').set({
      "lessonCardId": 003,
      "lessonCardTitle": "What do",
      "lessonCardDesc": "Sign of 'What do', this sign is usually shown at the last of signing sentence.",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'whatdo',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('word').set({
      "lessonCardId": 004,
      "lessonCardTitle": "Work",
      "lessonCardDesc": "Sign of 'Work'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'word',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('time').set({
      "lessonCardId": 005,
      "lessonCardTitle": "Time",
      "lessonCardDesc": "Sign of 'Time'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'time',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('bathroom').set({
      "lessonCardId": 006,
      "lessonCardTitle": "Bathroom",
      "lessonCardDesc": "Sign of 'Bathroom'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'bathroom',
      "isCompleted" : false,
    });

    ///Syllabus 2 Lesson 6
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('how').set({
      "lessonCardId": 001,
      "lessonCardTitle": "How",
      "lessonCardDesc": "Sign of 'How'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'how',
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('meaning').set({
      "lessonCardId": 002,
      "lessonCardTitle": "Meaning",
      "lessonCardDesc": "Sign of 'Meaning', which is used to ask the meaning the sign shown.",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'meaning',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('goodbye').set({
      "lessonCardId": 003,
      "lessonCardTitle": "Goodbye",
      "lessonCardDesc": "Sign of 'Goodbye'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'goodbye',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('culater').set({
      "lessonCardId": 004,
      "lessonCardTitle": "See you later",
      "lessonCardDesc": "Sign of 'See you later'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'culater',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('takecare').set({
      "lessonCardId": 005,
      "lessonCardTitle": "Take care",
      "lessonCardDesc": "Sign of 'Take care'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'takecare',
      "isCompleted" : false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').collection('Lesson 5').doc('howareyou').set({
      "lessonCardId": 006,
      "lessonCardTitle": "How are you",
      "lessonCardDesc": "Sign of 'How are you'",
      "lessonCardImage": "assets/image/lesson_1_thumbnail.png",
      "lessonId": 'howareyou',
      "isCompleted" : false,
    });

    ///Lesson Status
    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 1').doc('Lesson 1').set({
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 2').doc('Lesson 2').set({
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 3').doc('Lesson 3').set({
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 4').doc('Lesson 4').set({
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 5').doc('Lesson 5').set({
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').collection('Lesson 6').doc('Lesson 6').set({
      "isCompleted": false,
    });

    await userCollection.doc(uid).collection('lessons').doc('Syllabus 2').set({
      "isCompleted": false,
    });
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

  List<LessonModel>? _SyllabusList(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return LessonModel(
        lessonDesc:  doc['lessonDesc'],
        lessonId: doc['lessonId'],
        lessonImage: doc['lessonImage'],
        lessonName: doc['lessonName'],
      );
    }).toList();
  }

  Stream<List<LessonModel>?> getSyllabus(String Syllabus){
    return lessonsCollection.doc(Syllabus).collection('lessonsOverview').snapshots()
        .map(_SyllabusList);
  }

  List<LessonCardModel> _lessonCardList(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return LessonCardModel(
        lessonCardDesc: doc['lessonCardDesc'],
        lessonCardId: doc['lessonCardId'],
        lessonCardImage: doc['lessonCardImage'],
        lessonCardTitle: doc['lessonCardTitle'],
      );
    }).toList();
  }

  Stream<List<LessonCardModel>> getSelectedLessonCard(String Syllabus, String Lesson){
    return userCollection.doc(uid).collection('lessons').doc(Syllabus).collection(Lesson).doc(Lesson).collection(Lesson).snapshots()
        .map(_lessonCardList);
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


