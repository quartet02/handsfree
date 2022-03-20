import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handsfree/services/database.dart';

class NewUser {
  final String? uid;

  NewUser({this.uid});

  get userUid{
    return uid;
  }
}

class NewUserActivityLog {
  final List? activity;
  final Timestamp? lastLoginIn;

  NewUserActivityLog({this.lastLoginIn, this.activity});
}

class NewUserData {
  late final String? uid;
  late final String? name;
  late final int? experience;
  late final String? phoneNumber;
  late final String? picture;
  late final String? title;
  late final String? username;
  late final String? email;

  NewUserData(
      {this.name,
      this.uid,
      this.experience,
      this.phoneNumber,
      this.picture,
      this.title,
      this.username});

  factory NewUserData.fromMap(Map data){
    return NewUserData(
      uid: data['uid'],
      name: data['name'],
      experience: data['experience'],
      phoneNumber: data['phoneNumber'],
      picture: data['picture'],
      title: data['title'],
      username: data['username'],
    );
  }
}
