import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/newUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
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
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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
      await _auth.signInWithCredential(credential);
      return [0, 'Logged in successfully'];
    } on FirebaseAuthException catch (e) {
        return [1, e.code];
    } catch (e) {
      return [1, e.toString()];
    }
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
