import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/widgets/loadingWholeScreen.dart';
import 'package:handsfree/services/userPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:handsfree/widgets/loadingWholeScreen.dart';
import '../models/newUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      print(user.displayName);
      // add uid to SharedPreferences for easy access
      await UserPreference.setValue("uniqueId", user.uid);
      // print("set user preference with ${user.uid}");

      // init user database on successful registeration
      await DatabaseService(uid: user.uid)
        ..updateUserData(
            0,
            user.displayName ?? email.substring(0, email.lastIndexOf('@')),
            user.phoneNumber ?? "",
            'assets/image/character.png',
            'Newbie Signer',
            email.substring(0, email.lastIndexOf('@')))
        ..buildUserLesson();

      return [0, 'Account created successfully'];
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return [1, 'The account already exists for that email.'];
      } else if (e.code == 'weak-password') {
        return [1, 'The password provided is too weak'];
      } else {
        return [1, e.code];
      }
    } catch (e) {
      return [1, e.toString()];
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      User user = result.user!;

      // add uid to SharedPreferences for easy access
      await UserPreference.setValue("uniqueId", user.uid);

      DatabaseService(uid: user.uid);
      var activities =
          await DatabaseService(uid: user.uid).getActivityLog("List");
      var time = await DatabaseService(uid: user.uid).getActivityLog("Time");
      await DatabaseService(uid: user.uid)
          .updateActivityLog(activities!, time!);
      // set local user profileDetails

      return [0, 'Logged in successfully'];
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return [1, 'No user found for that email'];
      } else if (e.code == 'wrong-password') {
        return [1, 'Wrong password'];
      } else {
        return [1, e.code];
      }
    } catch (e) {
      return [1, e.toString()];
    }
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user!;

      // add uid to SharedPreferences for easy access
      final pref = await SharedPreferences.getInstance();
      await pref.setString("uniqueId", user.uid);

      DatabaseService(uid: user.uid);

      return [0, 'Logged in successfully'];
    } on FirebaseAuthException catch (e) {
      return [1, e.code];
    } catch (e) {
      return [1, e.toString()];
    }
  }

  void changePassword(String password) async {
    User user = FirebaseAuth.instance.currentUser!;
    user.updatePassword(password).then((_) {
      print("Successfully Change Password");
    }).catchError((error) {
      print("Password can't be changed " + error.toString());
    });
  }

  void signOut() async {
    await _auth.signOut();
  }

  NewUser? _userFromFirebaseUser(User? user) {
    return user != null ? NewUser(uid: user.uid) : null;
  }

  Stream<NewUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
}
