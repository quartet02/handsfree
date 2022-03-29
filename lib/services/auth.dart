import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handsfree/services/database.dart';
import 'package:handsfree/services/userPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/newUser.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      User user = result.user!;

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
        ..buildUserLesson()
        ..buildUserLog()
        ..buildUserFriend();

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

      // for testing initializable database
      // await DatabaseService(uid: user.uid)..buildUserLesson()
      //         ..buildUserFriend();

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
      if(result.additionalUserInfo!.isNewUser){
        // init user database on successful registeration
        await DatabaseService(uid: user.uid)
          ..updateUserData(
              0,
              user.displayName ?? user.email!.substring(0, user.email!.lastIndexOf('@')),
              user.phoneNumber ?? "",
              'assets/image/character.png',
              'Newbie Signer',
              user.email!.substring(0, user.email!.lastIndexOf('@')))
          ..buildUserLesson()
          ..buildUserLog()
          ..buildUserFriend();
      };
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

  Future<NewUserData?> _newUserDataFromFirebaseUser(User? user) async {
    var snap = await DatabaseService().getNewUserDataSnapshot(user);
    return snap == null
        ? null
        : NewUserData.fromMap(snap.data() as Map<String, dynamic>);
  }

  Stream<NewUserData?> get newUserData {
    return _auth.authStateChanges().asyncMap(_newUserDataFromFirebaseUser);
  }
}
