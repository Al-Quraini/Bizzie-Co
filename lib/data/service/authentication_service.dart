import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'firestore_service.dart';

class AuthenticationService {
  final auth.FirebaseAuth _auth;

  AuthenticationService({auth.FirebaseAuth? firebaseAuth})
      : _auth = firebaseAuth ?? auth.FirebaseAuth.instance;

  /// Sign in with credentials
  Future firebaseSignIn(auth.AuthCredential credential) async {
    return await _auth.signInWithCredential(credential);
  }

// This method handles the login
  Future signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await FirestoreService()
          .loadUserData(userUid: AuthenticationService().getUser()!.uid);

      // await FirestoreService().getConnections();
      return null;
    } catch (e) {
      List<String> messageArray = e.toString().split(' ');
      messageArray.removeAt(0);
      String error = messageArray.join(' ');

      return error;
    }
  }

// register new user with email and password
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return null;
    } catch (e) {
      List<String> messageArray = e.toString().split(' ');
      messageArray.removeAt(0);
      String error = messageArray.join(' ');
      return error;
    }
  }

  bool isSignedIn() {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }

  auth.User? getUser() {
    return _auth.currentUser;
  }

// sign out user
  Future userSignOut() async {
    await _auth.signOut();
  }
}
